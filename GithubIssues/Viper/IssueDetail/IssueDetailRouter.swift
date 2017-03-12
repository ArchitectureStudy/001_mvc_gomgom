//
//  File.swift
//  GithubIssues
//
//  Created by leechanggwi on 2017. 3. 12..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import UIKit

class IssueDetailRouter: NSObject, GitHubRouterProtocol {
    
    var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    init(viewController: UIViewController, navigationController: UINavigationController?) {
        self.viewController = viewController
        
        if navigationController != nil {
            self.navigationController = navigationController
        }
    }
}
