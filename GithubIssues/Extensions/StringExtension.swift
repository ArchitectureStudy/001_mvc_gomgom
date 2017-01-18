//
//  StringExtension.swift
//  AfreecaTV-LetMeIn-Swift
//
//  Created by Chang Gwi Lee on 2016. 12. 7..
//  Copyright © 2016년 AfreecaTV. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func toTypeSafeInt() -> Int {
        if let safeInt = Int(self) {
            return safeInt
        } else {
            return 0
        }
    }
}
