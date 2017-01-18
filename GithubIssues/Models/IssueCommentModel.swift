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



class IssueCommentModel {
    
    let user:String
    let repo:String
    let number:Int
    
    var issueDetail:IssueCommentItem = IssueCommentItem()
    
    func request() {
        APIManager.sharedInstance.requestHTTPTask(.get, urlString: "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)/comments",
            parameters: nil,
            successBlock: {
                [weak self] (result) in
                guard let weakSelf = self else { return }
                weakSelf.issueDetail = Mapper<IssueCommentItem>().map(JSONObject: result)!
                NotificationCenter.default.post(name: .IssueDetailRequestCompletedNotification, object: weakSelf)
        }) { (error) in
            print(error)
        }
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
