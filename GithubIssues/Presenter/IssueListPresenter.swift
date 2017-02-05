//
//  IssueListPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 11..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift

protocol IssueListPresenterProtocol {
    func displayIssues(issueItems: [IssueItem])
}

class IssueListPresenter {
    
    var disposeBag = DisposeBag()
    
    let manager = UserInfoManager.sharedInstance
    
    let model:IssueListModel
    var view:IssueListPresenterProtocol!
    
    init(view:IssueListPresenterProtocol) {
        
        self.view = view;
        self.model = IssueListModel(user: manager.user, repo: manager.repo)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(onIssueRequestCompletedNotification(_:)), name: .IssueRequestCompletedNotification, object: nil)
    }
    
    
    @objc func onIssueRequestCompletedNotification(_ notification: Notification) {
        print("onIssueRequestCompletedNotification IN")
        //self.view.displayIssues(issueItems: model.issues)
    }
    
    func issuesRequest() {
        // api request
        // 유저 정보 로딩이 완료되면 리프레쉬되게
        self.model.issuesVariable.asObservable().subscribe(onNext: issueListReload).addDisposableTo(disposeBag)
        self.model.request()
    }
    
    func issueListReload(issues: [IssueItem]) {
        self.view.displayIssues(issueItems: issues)
    }

    
}
