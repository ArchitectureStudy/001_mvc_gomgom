//
//  IssueListInteractor.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 2..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

class IssueListInteractor {
    
    let manager = UserInfoManager.sharedInstance
    
    var disposeBag = DisposeBag()
    var viewModel: IssueListViewModel!
    var dataService: IssueListDataService!
    
    var issuesListReloadSubject: PublishSubject<([IssueItem])> = PublishSubject<([IssueItem])>()
    
    init(user: String, repo: String) {
        viewModel = IssueListViewModel(user: user, repo: repo)
    }
    
    func issueRquest() {
        self.viewModel.model.issuesVariable.asObservable().subscribe(onNext: issueListReload).addDisposableTo(disposeBag)
        self.dataService.getIssueItems().bindTo(self.viewModel.model.issuesVariable).addDisposableTo(disposeBag)
    }
    
    func issueListReload(issues: [IssueItem]) {
        let issueListDataDict:[String: [Any]] = ["issueListData": issues]
        NotificationCenter.default.post(name: .IssueListRequestCompletedNotification, object: self.viewModel, userInfo: issueListDataDict)
    }
}
