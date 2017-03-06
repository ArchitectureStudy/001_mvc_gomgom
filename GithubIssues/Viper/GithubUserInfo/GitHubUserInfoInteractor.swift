//
//  GitHubUserInfoInteractor.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 5..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class GitHubUserInfoInteractor {
    
    func getUserInfo() -> Observable<JSON> {
        return APIRequest.getUserInfo()
    }
    
    func deleteToken() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "accessToken")
        userDefaults.synchronize()
        UserInfoManager.sharedInstance.accessToken = ""
    }
}
