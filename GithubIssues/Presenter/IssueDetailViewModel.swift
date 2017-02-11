//
//  IssueDetailViewModel.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift

protocol IssueDetailViewModelProtocol {
    func displayIssueDetail(issueItem:IssueDetailItem)
    func displayIssueDetailComments(issueItems:[IssueCommentItem])
    func displayIssueWriteComments(issueItems:[IssueCommentItem])
}

class IssueDetailViewModel {
    
    var disposeBag = DisposeBag()
    
    let manager = UserInfoManager.sharedInstance
    
    let model:IssueDetailModel
    let modelComment:IssueCommentModel
    
    var view:IssueDetailViewModelProtocol!
    
    init(view:IssueDetailViewModelProtocol, selectedItem:IssueItem) {
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
        //self.view.displayIssueDetailComments(issueItems: modelComment.issueComments)
    }
    
    @objc func onIssueWriteCommentsRequestCompletedNotification(_ notification: Notification) {
        //print("onIssueDetailCommentsRequestCompletedNotification IN")
        //self.view.displayIssueWriteComments(issueItems: modelComment.issueComments)
    }
    
    func issuesRequest() {
        // api request
        self.model.request()
        
        self.modelComment.issueCommentsVariable.asObservable().subscribe(onNext: issueCommentReload).addDisposableTo(disposeBag)
        self.modelComment.request()
    }
    
    func issueCommentReload(comments: [IssueCommentItem]) {
        self.view.displayIssueDetailComments(issueItems: self.modelComment.issueCommentsVariable.value)
    }
    
    func writeComment(comment:String) {
        self.modelComment.commentPost(comment: comment)
    }
    
}
