//
//  IssueDetailPresenter.swift
//  GithubIssues
//
//  Created by leechanggwi on 2017. 3. 12..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueDetailPresenterProtocol {
    func displayDeatailIssue(issues: IssueItem)
    func displayCommentIssues(commentItems: [IssueCommentItem])
}

class IssueDetailPresenter {
    let manager = UserInfoManager.sharedInstance
    
    var router: IssueDetailRouter!
    var interactor: IssueDetailInteractor
    var view:IssueDetailPresenterProtocol!
    
    
    init(view:IssueDetailPresenterProtocol, selectedItem: IssueItem) {
        self.view = view
        self.interactor = IssueDetailInteractor(user: manager.user, repo: manager.repo, selectedItem: selectedItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueListRequestCompletedNotification(_:)), name: Notification.Name.Interactor.detailCommentsRequestComplete, object: nil)
        
        self.view.displayDeatailIssue(issues: selectedItem)
    }
    
    func getDetailInfo() {
        self.interactor.issueRquest()
    }
    
    @objc func onIssueListRequestCompletedNotification(_ notification: Notification) {
        //        if let issueListData = notification.userInfo?["issueListData"] as? [IssueItem] {
        //            self.view.displayIssueList(issues: issueListData)
        //        }
        
        if let viewModel = notification.object as? IssueDetailViewModel {
            self.view.displayCommentIssues(commentItems: viewModel.modelComment.issueCommentsVariable.value)
        }
    }
    
}
