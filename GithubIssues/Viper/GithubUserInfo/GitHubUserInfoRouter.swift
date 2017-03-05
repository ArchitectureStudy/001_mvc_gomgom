//
//  GitHubUserInfoRouter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 3..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import UIKit

class GitHubUserInfoRouter: NSObject, GitHubRouterProtocol {
    
    var navigationController: UINavigationController?
    var viewController: UIViewController?
    
    init(viewController: UIViewController, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.navigationController = nil
    }
    
    init(navigationController: UINavigationController) {
        self.viewController = navigationController.viewControllers.first
        self.navigationController = navigationController
    }
    
    func showTokenInputTextField() {
        let viewController = self.viewController as? GithubUserInfoViewController
        viewController?.performSegue(withIdentifier: "sequeShowUserTokenViewController", sender: self)
    }
    
    func showIssueList() {
        // 이걸 구현해야 하는지 모르겠다... 스토리보드에서 해주는데..
        // 아무것도 안해도 된다...
    }
}
