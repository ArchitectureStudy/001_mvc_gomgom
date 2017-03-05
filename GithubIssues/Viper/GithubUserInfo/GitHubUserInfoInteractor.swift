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
}
