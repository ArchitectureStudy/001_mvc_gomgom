//
//  ViewModelProtocol.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 10..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    //var services: ViewModelServicesProtocol { get }
    
    var title: String { get }
    var number: Int { get }
    var comment: Int { get }    
}

extension ViewModelProtocol {
    var title: String {
        return ""
    }
    
    var number: Int {
        return 0
    }
    
    var comment: Int {
        return 0
    }
}
