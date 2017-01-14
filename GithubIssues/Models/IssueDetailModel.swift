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
        //https://api.github.com/repos/freeCodeCamp/freeCodeCamp/issues/12518
        Alamofire.request("https://api.github.com/repos/\(user)/\(repo)/issues/\(number)").responseJSON { [weak self] response in
            guard let weakSelf = self else { return }
            switch (response.result){
                case .success:
                    let json = response.result.value
                    weakSelf.issueDetail = Mapper<IssueDetailItem>().map(JSONObject: json)!
                    NotificationCenter.default.post(name: .IssueDetailRequestCompletedNotification, object: weakSelf)
                    break
                case .failure:
                    
                    break
            }
            
        }
    }
    
    init(user: String, repo: String, number:Int) {
        self.user = user
        self.repo = repo
        self.number = number
    }
}
