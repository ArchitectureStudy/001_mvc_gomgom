//
//  IssueCommentModel.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 18..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import p2_OAuth2


class IssueCommentModel {
    
    let user:String
    let repo:String
    let number:Int
    
    var issueComments:[IssueCommentItem] = []
    
    func request() {
        APIManager.sharedInstance.requestHTTPTask(.get, urlString: "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)/comments",
            parameters: nil,
            successBlock: {
                [weak self] (result) in
                guard let weakSelf = self else { return }
                if let json = result as? [[String: AnyObject]] {
                    weakSelf.issueComments = Mapper<IssueCommentItem>().mapArray(JSONArray: json)!
                }
                
                NotificationCenter.default.post(name: .IssueDetailCommentsRequestCompletedNotification, object: weakSelf)
        }) { (error) in
            print(error)
        }
    }
    
    func commentPost(comment:String) {
        
        let url = URL(string: "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)/comments")
        var request = IssueUserInfoManager.sharedInstance.oauth2.request(forURL: url!)
        request.httpMethod = "post"
        let parameters = ["body" : comment]

        request = try! JSONEncoding.default.encode(request, with: parameters)
        // OAuth 라이브러리에서 token 이라고 안넣어준다!! 왜지..뭐지..모르겠다.
        request.setValue("token \(IssueUserInfoManager.sharedInstance.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = IssueUserInfoManager.sharedInstance.oauth2.session.dataTask(with: request) { [weak self] data, response, error in
            
            if error != nil {
                // something went wrong, check the error
                print("error=\(error)")
                return
            }
            else {
                // check the response and the data
                // you have just received data with an OAuth2-signed request!
                guard let weakSelf = self else { return }
                guard let responseString = String(data: data!, encoding: .utf8) else { return }
                
                print("responseString = \(responseString)")
                
                let jsonResponse = weakSelf.convertToDictionary(text: responseString)
                
                if let json = jsonResponse as [String: Any]? {
                    if let commentItem = Mapper<IssueCommentItem>().map(JSON: json) {
                        weakSelf.issueComments.append(commentItem)
                    }
                }
                
                NotificationCenter.default.post(name: .IssueWriteCommentsRequestCompletedNotification, object: responseString)
            }
        }
        task.resume()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    init(user: String, repo: String, number:Int) {
        self.user = user
        self.repo = repo
        self.number = number
    }
}


/*
 {
 "url": "https://api.github.com/repos/Alamofire/Alamofire/issues/comments/271693530",
 "html_url": "https://github.com/Alamofire/Alamofire/issues/1901#issuecomment-271693530",
 "issue_url": "https://api.github.com/repos/Alamofire/Alamofire/issues/1901",
 "id": 271693530,
 "user": {
     "login": "jshier",
     "id": 51020,
     "avatar_url": "https://avatars.githubusercontent.com/u/51020?v=3",
     "gravatar_id": "",
     "url": "https://api.github.com/users/jshier",
     "html_url": "https://github.com/jshier",
     "followers_url": "https://api.github.com/users/jshier/followers",
     "following_url": "https://api.github.com/users/jshier/following{/other_user}",
     "gists_url": "https://api.github.com/users/jshier/gists{/gist_id}",
     "starred_url": "https://api.github.com/users/jshier/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/jshier/subscriptions",
     "organizations_url": "https://api.github.com/users/jshier/orgs",
     "repos_url": "https://api.github.com/users/jshier/repos",
     "events_url": "https://api.github.com/users/jshier/events{/privacy}",
     "received_events_url": "https://api.github.com/users/jshier/received_events",
     "type": "User",
     "site_admin": false
 },
 "created_at": "2017-01-10T20:48:48Z",
 "updated_at": "2017-01-10T20:48:48Z",
 "body": "Can you post the code that's causing the crash, along with the versions of Alamofire, Xcode, the operating systems you're seeing the crash on?"
 }
 */
class IssueCommentItem:IssueItem {
    
    override func mapping(map: Map) {
        url <- map["url"]
        id <- map["id"]
        created_at <- map["created_at"]
        body <- map["body"]
        
        User <- map["user"]
    }
}
