//
//  IssueCollectionViewCellViewModel.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 10..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation


struct IssueCollectionViewCellViewModel: ViewModelProtocol {
    
    let item: IssueItem
    
    init(item: IssueItem) {
        self.item = item
    }
    
    var title: String {
        return self.item.title
    }
    
    var number: Int {
        return self.item.number
    }
    
    var comment: Int {
        return self.item.comments
    }
}
