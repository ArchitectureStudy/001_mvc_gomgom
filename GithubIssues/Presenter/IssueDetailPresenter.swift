//
//  IssueDetailPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueDetailPresenterProtocol {
    func displayDetailIssue(issueItem:IssueDetailItem)
}

class IssueDetailPresenter {
    
    let manager = IssueUserInfoManager.sharedInstance
    
    let model:IssueDetailModel
    let modelComment:IssueCommentModel
    
    var view:IssueDetailPresenterProtocol!
    
    init(view:IssueDetailPresenterProtocol, selectedItem:IssueItem) {
        self.view = view;
        self.model = IssueDetailModel(user: manager.user, repo: manager.repo, number: selectedItem.number)
        self.modelComment = IssueCommentModel(user: manager.user, repo: manager.repo, number: selectedItem.number)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueDetailRequestCompletedNotification(_:)), name: .IssueDetailRequestCompletedNotification, object: nil)
    }
    
    
    @objc func onIssueDetailRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailRequestCompletedNotification IN")
        self.view.displayDetailIssue(issueItem: model.issueDetail)
    }
    
    func issuesRequest() {
        // api request
        self.model.request()
    }
    
}
