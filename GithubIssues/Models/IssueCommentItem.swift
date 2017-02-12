//
//  IssueCommentItem.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 13..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import ObjectMapper

struct IssueCommentItem:ImmutableMappable{
    let url:String
    let id:Int
    let created_at:Date?
    let body:String
    
    let user:IssueItemUser
    
    init(map: Map) throws {
        url = try map.value("url")
        id = try map.value("id")
        created_at = try? map.value("created_at", using: DateTransform())
        body = try map.value("body")
        
        user = try map.value("user")
    }
    
    mutating func mapping(map: Map) {
        url >>> map["url"]
        id >>> map["id"]
        created_at >>> map["created_at"]
        body >>> map["body"]
        
        user >>> map["user"]
    }
}
