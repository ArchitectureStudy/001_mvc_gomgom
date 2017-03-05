//
//  GitHubRouter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 5..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import UIKit

protocol GitHubRouterProtocol {
    weak var navigationController: UINavigationController? { get set }
    weak var viewController: UIViewController? { get set }
    
    func push(viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool, completion: (()->Void)?)
}


extension GitHubRouterProtocol {
    func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion: (()->Void)? = nil) {
        self.viewController?.present(viewController, animated: animated, completion: nil)
    }
}
