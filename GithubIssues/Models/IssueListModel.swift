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
    
    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
}
