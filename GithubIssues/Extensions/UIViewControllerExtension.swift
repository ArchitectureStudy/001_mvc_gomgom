//
//  UIViewControllerExtension.swift
//  AfreecaTV-LetMeIn-Swift
//
//  Created by Chang Gwi Lee on 2016. 12. 7..
//  Copyright © 2016년 AfreecaTV. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
//        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
//        self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
}
