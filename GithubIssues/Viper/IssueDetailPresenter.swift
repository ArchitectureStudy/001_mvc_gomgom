//
//  IssueDetailPresenter.swift
//  GithubIssues
//
//  Created by leechanggwi on 2017. 3. 12..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueDetailPresenterProtocol {
    func displayIssueList(issues: [IssueItem])
}

class IssueDetailPresenter {
    let manager = UserInfoManager.sharedInstance
    
    var router: IssueDetailRouter!
//    var interactor: IssueDetailInteractor
    var view:IssueDetailPresenterProtocol!
    
    
    init(view:IssueDetailPresenterProtocol) {
        self.view = view
//        self.interactor = IssueListInteractor(user: manager.user, repo: manager.repo)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueListRequestCompletedNotification(_:)), name: .IssueListRequestCompletedNotification, object: nil)
    }
    
    func getIssueItems() {
//        self.interactor.issueRquest()
    }
    
    @objc func onIssueListRequestCompletedNotification(_ notification: Notification) {
        //        if let issueListData = notification.userInfo?["issueListData"] as? [IssueItem] {
        //            self.view.displayIssueList(issues: issueListData)
        //        }
        
        if let viewModel = notification.object as? IssueListViewModel {
            self.view.displayIssueList(issues: viewModel.model.issuesVariable.value)
        }
    }
    
}
