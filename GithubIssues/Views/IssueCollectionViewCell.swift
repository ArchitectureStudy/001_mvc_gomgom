//
//  IssueCollectionViewCell.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 6..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit

class IssueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var issueTitleLabel: UILabel!
    
    var issueNumber: String? {
        didSet {
            issueNumberLabel.text = issueNumber
        }
    }
    
    var issueTitle: String? {
        didSet {
            issueTitleLabel.text = issueTitle
        }
    }

    
}
