//
//  GitHubUserInfoRouter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 3..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import UIKit

protocol GitHubUserInfoRouterInput {
    func push()
}

class GitHubUserInfoRouter: NSObject,GitHubUserInfoRouterInput {
    
    weak var navigationController: UINavigationController?
    weak var viewController: GithubUserInfoViewController?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push() {
        let issueListViewController: IssueListViewController = IssueListViewController()
        self.navigationController?.pushViewController(issueListViewController, animated: true);
    }
}
