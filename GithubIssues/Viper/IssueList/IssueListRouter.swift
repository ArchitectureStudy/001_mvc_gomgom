//
//  IssueListRouter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 2..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import UIKit

protocol IssueListRouterInput {
    func push()
    func present()
}

class IssueListRouter: NSObject, IssueListRouterInput {

    weak var viewController: UIViewController!
    weak var navigationController: UINavigationController?
    
    init(viewController: UIViewController, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func push() {
        
    }
    
    func present() {
        
    }
}
