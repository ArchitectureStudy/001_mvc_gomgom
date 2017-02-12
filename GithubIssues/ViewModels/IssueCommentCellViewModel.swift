//
//  IssueCommentCellViewModel.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 13..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

struct IssueCommentCellViewModel: ViewModelCommentProtocol {

    let item: IssueCommentItem
        
    init(item: IssueCommentItem) {
        self.item = item
    }
    
    var avatar_url: String {
        return self.item.user.avatar_url
    }
    
    var username: String {
        return self.item.user.login
    }
    
    var body: String {
        return self.item.body
    }
    
    internal var user: IssueItemUser {
        return self.item.user
    }
}
