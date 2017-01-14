//
//  GithubUser.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

class IssueUserInfoManager: NSObject {
    
    static let sharedInstance = IssueUserInfoManager()
    
    var repo:String
    var user:String
    var secretKey:String
    
    override init() {
        self.repo = ""
        self.user = ""
        self.secretKey = ""
    }    
}
