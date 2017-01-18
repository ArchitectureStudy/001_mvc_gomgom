//
//  UIViewExtension.swift
//  AfreecaTV-LetMeIn-Swift
//
//  Created by Chang Gwi Lee on 2016. 12. 8..
//  Copyright © 2016년 AfreecaTV. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
}
