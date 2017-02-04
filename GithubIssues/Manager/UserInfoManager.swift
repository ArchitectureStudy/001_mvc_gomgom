//
//  UserInfoManager.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 3..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {
    
    static let sharedInstance = IssueUserInfoManager()

    var repo:String
    var user:String
    var accessToken:String
    
    override init() {
        self.repo = ""
        self.user = ""
        self.accessToken = ""
    }
    
}
