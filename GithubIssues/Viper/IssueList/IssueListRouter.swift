//
//  IssueListRouter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 2..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import UIKit

class IssueListRouter: NSObject, GitHubRouterProtocol {
    
    var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    init(viewController: UIViewController, navigationController: UINavigationController?) {
        self.viewController = viewController
        
        if navigationController != nil {
            self.navigationController = navigationController
        }
    }    
}

class IssueDatailSegue: UIStoryboardSegue {
    override func perform() {
        guard let listViewController = source as? IssueListViewController else { return; }
        guard let detailViewController = destination as? IssueDetailViewController else { return; }
        
        listViewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
