//
//  IssueDetailPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueDetailPresenterProtocol {
    func displayIssueDetail(issueItem:IssueDetailItem)
    func displayIssueDetailComments(issueItems:[IssueCommentItem])
    func displayIssueWriteComments(issueItems:[IssueCommentItem])
}

class IssueDetailPresenter {
    
    let manager = UserInfoManager.sharedInstance
    
    let model:IssueDetailModel
    let modelComment:IssueCommentModel
    
    var view:IssueDetailPresenterProtocol!
    
    init(view:IssueDetailPresenterProtocol, selectedItem:IssueItem) {
        self.view = view;
        self.model = IssueDetailModel(user: manager.user, repo: manager.repo, number: selectedItem.number)
        self.modelComment = IssueCommentModel(user: manager.user, repo: manager.repo, number: selectedItem.number)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueDetailRequestCompletedNotification(_:)), name: .IssueDetailRequestCompletedNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueDetailCommentsRequestCompletedNotification(_:)), name: .IssueDetailCommentsRequestCompletedNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueWriteCommentsRequestCompletedNotification(_:)), name: .IssueWriteCommentsRequestCompletedNotification, object: nil)
    }
    
    
    @objc func onIssueDetailRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailRequestCompletedNotification IN")
        self.view.displayIssueDetail(issueItem: model.issueDetail)
    }
    
    @objc func onIssueDetailCommentsRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailCommentsRequestCompletedNotification IN")
        self.view.displayIssueDetailComments(issueItems: modelComment.issueComments)
    }
    
    @objc func onIssueWriteCommentsRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailCommentsRequestCompletedNotification IN")
        self.view.displayIssueWriteComments(issueItems: modelComment.issueComments)
    }
    
    func issuesRequest() {
        // api request
        self.model.request()
        self.modelComment.request()
    }
    
    func writeComment(comment:String) {
        self.modelComment.commentPost(comment: comment)
    }
    
}
