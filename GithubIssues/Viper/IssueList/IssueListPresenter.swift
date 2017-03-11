//
//  IssueListPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 2..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueListPresenterProtocol {
    func displayIssueList(issues: [IssueItem])
}

class IssueListPresenter {
    let manager = UserInfoManager.sharedInstance
    
    var router: IssueListRouter!
    var interactor: IssueListInteractor
    var view:IssueListPresenterProtocol!

    
    init(view:IssueListPresenterProtocol) {
        self.view = view
        self.interactor = IssueListInteractor(user: manager.user, repo: manager.repo)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueListRequestCompletedNotification(_:)), name: .IssueListRequestCompletedNotification, object: nil)
    }
    
    func getIssueItems() {
        self.interactor.issueRquest()
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
