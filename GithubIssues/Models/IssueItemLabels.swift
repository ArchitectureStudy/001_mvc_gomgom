//
//  IssueItemLabels.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 "labels": [
 {
 "id": 199856930,
 "url": "https://api.github.com/repos/FreeCodeCamp/FreeCodeCamp/labels/QA",
 "name": "QA",
 "color": "ededed",
 "default": false
 }
 ],
 
 */

class IssueItemLabels:Mappable{
    var url:String = ""
    var id:Int = 0
    var name:String = ""
    var color:String = ""
    
    init() {}
    required init?(map: Map) {}
    func mapping(map: Map) {
        url <- map["url"]
        id <- map["id"]
        name <- map["name"]
        color <- map["color"]
    }
}
