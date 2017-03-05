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
    
    init(viewController: UIViewController, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }    
}
