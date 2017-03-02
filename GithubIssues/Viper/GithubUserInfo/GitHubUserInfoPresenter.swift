//
//  GitHubUserInfoPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 3..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

class GitHubUserInfoPresenter {
    
    var router: GitHubUserInfoRouter!
    
    
    func showIssueList() {
        self.router.push()
    }
}
