//
//  GithubUser.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import p2_OAuth2

class IssueUserInfoManager: NSObject {
    
    static let sharedInstance = IssueUserInfoManager()
    
    var loader: OAuth2DataLoader?
    
    var oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "af1c542e34cc2cb919a8",                         // yes, this client-id and secret will work!
        "client_secret": "3bd94893094a92345a93d48076dbb42e9664ea7b",
        "authorize_uri": "https://github.com/login/oauth/authorize",
        "token_uri": "https://github.com/login/oauth/access_token",
        "scope": "user repo:status admin:org",
        "redirect_uris": ["githubissuesapp://oauth/callback"],            // app has registered this scheme
        "secret_in_body": true,                                      // GitHub does not accept client secret in the Authorization header
        "verbose": true,
        ] as OAuth2JSON)
    
    var repo:String
    var user:String
    var accessToken:String
    
    override init() {
        self.repo = ""
        self.user = ""
        self.accessToken = ""
    }    
}
