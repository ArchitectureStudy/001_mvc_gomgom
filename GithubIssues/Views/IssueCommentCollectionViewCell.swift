//
//  IssueCommentCollectionViewCell.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 18..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit

class IssueCommentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileThumbnail: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let toReturn = super.preferredLayoutAttributesFitting(layoutAttributes)
        return toReturn
    }
    
    func configure(withDelegate delegate: ViewModelCommentProtocol)
    {
        let url = URL(string: delegate.avatar_url)!
        let placeholderImage = UIImage(named: "placeholder")!
        self.profileThumbnail.af_setImage(withURL: url, placeholderImage: placeholderImage)
        self.usernameLabel.text = delegate.username
        self.commentLabel.text = delegate.body
    }
 
}
