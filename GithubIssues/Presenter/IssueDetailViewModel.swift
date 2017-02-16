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
    func displayIssueDetail(issueItem:IssueItem)
    func displayIssueDetailComments(commentItems:[IssueCommentItem])
    func displayIssueWriteComments(issueItems:[IssueCommentItem])
}

class IssueDetailViewModel {
    
    var disposeBag = DisposeBag()
    
    let manager = UserInfoManager.sharedInstance
    
    let model:IssueDetailModel
    let modelComment:IssueCommentModel
    
    //var view:IssueDetailViewModelProtocol!
    let issuesCommentReloadSubject: PublishSubject<([IssueCommentItem])> = PublishSubject<([IssueCommentItem])>()
    
    init(user:String, repo:String, selectedItem:IssueItem) {
        self.model = IssueDetailModel(user: user, repo: repo, number: selectedItem.number, issueDetail: selectedItem)
        self.modelComment = IssueCommentModel(user: user, repo: repo, number: selectedItem.number)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueDetailRequestCompletedNotification(_:)), name: .IssueDetailRequestCompletedNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueDetailCommentsRequestCompletedNotification(_:)), name: .IssueDetailCommentsRequestCompletedNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueWriteCommentsRequestCompletedNotification(_:)), name: .IssueWriteCommentsRequestCompletedNotification, object: nil)
    }
    
    
    @objc func onIssueDetailRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailRequestCompletedNotification IN")
        //self.view.displayIssueDetail(issueItem: model.issueDetail)
        //self.issuesCommentReloadSubject.onNext(<#T##element: Array<IssueItem>##Array<IssueItem>#>)
    }
    
    @objc func onIssueDetailCommentsRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailCommentsRequestCompletedNotification IN")
        //self.view.displayIssueDetailComments(issueItems: modelComment.issueComments)
    }
    
    @objc func onIssueWriteCommentsRequestCompletedNotification(_ notification: Notification) {
        //if let writeComment = notification.userInfo?["writeComment"] as? IssueCommentItem {
        //    let newComments = self.modelComment.issueCommentsVariable.value + [writeComment]
        //    self.modelComment.issueCommentsVariable.value = newComments
        //}
    }
    
    func issuesRequest() {
        // api request
        self.model.request()
        
        self.modelComment.issueCommentsVariable.asObservable().subscribe(onNext: issueCommentReload).addDisposableTo(disposeBag)
        self.modelComment.request()
    }
    
    func issueCommentReload(comments: [IssueCommentItem]) {
        //self.view.displayIssueDetailComments(commentItems: self.modelComment.issueCommentsVariable.value)
        self.issuesCommentReloadSubject.onNext(comments)
    }
    
    func writeComment(comment:String) {
        self.modelComment.commentPost(comment: comment)
    }
    
}
