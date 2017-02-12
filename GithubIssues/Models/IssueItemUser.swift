//
//  IssueItemUser.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 9..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 "user": {
 "login": "BerkeleyTrue",
 "id": 6775919,
 "avatar_url": "https://avatars.githubusercontent.com/u/6775919?v=3",
 "gravatar_id": "",
 "url": "https://api.github.com/users/BerkeleyTrue",
 "html_url": "https://github.com/BerkeleyTrue",
 "followers_url": "https://api.github.com/users/BerkeleyTrue/followers",
 "following_url": "https://api.github.com/users/BerkeleyTrue/following{/other_user}",
 "gists_url": "https://api.github.com/users/BerkeleyTrue/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/BerkeleyTrue/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/BerkeleyTrue/subscriptions",
 "organizations_url": "https://api.github.com/users/BerkeleyTrue/orgs",
 "repos_url": "https://api.github.com/users/BerkeleyTrue/repos",
 "events_url": "https://api.github.com/users/BerkeleyTrue/events{/privacy}",
 "received_events_url": "https://api.github.com/users/BerkeleyTrue/received_events",
 "type": "User",
 "site_admin": false
 }
 
 */

struct IssueItemUser:ImmutableMappable {
    let login:String
    let id:Int
    let avatar_url:String
    let type:String
    
    init(map: Map) throws {
        login = try map.value("login")
        id = try map.value("id")
        avatar_url = try map.value("avatar_url")
        type = try map.value("type")
    }
    
    mutating func mapping(map: Map) {
        login >>> map["login"]
        id >>> map["id"]
        avatar_url >>> map["avatar_url"]
        type >>> map["type"]
    }
}
