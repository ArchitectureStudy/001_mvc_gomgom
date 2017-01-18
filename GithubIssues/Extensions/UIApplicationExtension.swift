//
//  UIApplicationExtension.swift
//  AfreecaTV-LetMeIn-Swift
//
//  Created by Chang Gwi Lee on 2016. 12. 8..
//  Copyright © 2016년 AfreecaTV. All rights reserved.
//

import UIKit

extension UIApplication {
    class func frontViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return frontViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return frontViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return frontViewController(presented)
        }
        
        return viewController
    }
}

extension NSObject {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
