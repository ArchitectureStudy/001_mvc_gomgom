//
//  UINavigationExtension.swift
//  AfreecaTV-LetMeIn-Swift
//
//  Created by Chang Gwi Lee on 2016. 12. 7..
//  Copyright © 2016년 AfreecaTV. All rights reserved.
//

import UIKit

extension UINavigationController {
    func afreecaNavigationStyle() {
        self.navigationBar.barTintColor = UIColor(hexString: "0056CC")
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func afreecaLeftNavigationStyle() {
        self.navigationBar.barTintColor = UIColor(hexString: "0D3271")
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}
