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
import RxSwift


class IssueListModel {
    
    let user:String
    let repo:String
    
    var disposeBag = DisposeBag()
    var issuesVariable:Variable<[IssueItem]> = Variable<[IssueItem]>([])

    
    func request() {
//        APIManager.sharedInstance.requestHTTPTask(.get, urlString: "https://api.github.com/repos/\(user)/\(repo)/issues",
//            parameters: nil,
//            successBlock: {
//                [weak self] (result) in
//                guard let weakSelf = self else { return }
//                if let json = result as? [[String: AnyObject]] {
//                    weakSelf.issues = Mapper<IssueItem>().mapArray(JSONArray: json)!
//                }
//                NotificationCenter.default.post(name: .IssueRequestCompletedNotification, object: weakSelf)
//        }) { (error) in
//            print(error)
//        }
        
        // 유저 정보 읽어오기
        APIRequest.getIssues().bindTo(issuesVariable).addDisposableTo(disposeBag)
    }
    
    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
}
