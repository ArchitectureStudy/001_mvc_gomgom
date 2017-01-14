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
import ObjectMapper

class IssueListModel {
    
    let user:String
    let repo:String
    
    var issues:[IssueListItem] = []
    
    func request() {
        Alamofire.request("https://api.github.com/repos/\(user)/\(repo)/issues").responseJSON { [weak self] response in
            guard let weakSelf = self else { return }
            if let json = response.result.value as? [[String: AnyObject]] {
                
                weakSelf.issues = Mapper<IssueListItem>().mapArray(JSONArray: json)!
                                
                NotificationCenter.default.post(name: .IssueRequestCompletedNotification, object: weakSelf)
            }
        }
    }
    
    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
}
