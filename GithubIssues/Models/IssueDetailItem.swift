//
//  IssueDeatilItem.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import ObjectMapper

class IssueDetailItem:IssueItem {
    
    override func mapping(map: Map) {
        url <- map["url"]
        repository_url <- map["repository_url"]
        id <- map["id"]
        number <- map["number"]
        title <- map["title"]
        User <- map["user"]
    }
}
