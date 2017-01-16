//
//  IssueDetailModel.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class IssueDetailModel {
    
    let user:String
    let repo:String
    let number:Int
    
    var issueDetail:IssueDetailItem = IssueDetailItem()
    
    func request() {
        APIManager.sharedInstance.requestHTTPTask(.get, urlString: "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)",
            parameters: nil,
            successBlock: {
                [weak self] (result) in
                guard let weakSelf = self else { return }
                weakSelf.issueDetail = Mapper<IssueDetailItem>().map(JSONObject: result)!
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