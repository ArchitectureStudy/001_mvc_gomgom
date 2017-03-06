//
//  IssueListViewModel.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 11..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class IssueListViewModel {
    
    let model:IssueListModel
    
    init(user:String, repo:String) {
        self.model = IssueListModel(user: user, repo: repo)
    }

}
