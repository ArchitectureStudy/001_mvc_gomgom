//
//  IssueModel.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 6..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let IssueRequestCompletedNotification: Notification.Name = Notification.Name("IssueRequestCompleted")

class IssueModel {
    
    let user:String
    let repo:String
    
    var issues:[String] = []  // Data Class 생성해야함.
    
    func request() {
        Alamofire.request("https://api.github.com/repos/\(user)/\(repo)/issues").responseJSON { [weak self] response in
            guard let weakSelf = self else { return }
            if let json = response.result.value as? [[String: AnyObject]] {
                weakSelf.issues = []
                
                json.forEach { issueJson in
                    let json = JSON(issueJson)
                    let id = json["id"].int ?? 0
                    let title = json["title"].string ?? ""
                    weakSelf.issues.append("\(id) : \(title)")
                }
                
                NotificationCenter.default.post(name: IssueRequestCompletedNotification, object: weakSelf)
            }
        }
    }
    
    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
}
