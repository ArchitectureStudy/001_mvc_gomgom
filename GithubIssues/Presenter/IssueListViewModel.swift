//
//  IssueListViewModel.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 11..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//protocol IssueListViewModelProtocol {
//    func displayIssues(issueItems: [IssueItem])
//}

class IssueListViewModel {
    
    var disposeBag = DisposeBag()
    
    let model:IssueListModel
    //var view:IssueListViewModelProtocol!
    
//    let issuesReloadSubject: PublishSubject<([IssueItem])> = PublishSubject<([IssueItem])>()
    var issueReloadDrive: Driver<[IssueItem]> {
        get {
            return self.model.issuesVariable.asObservable().asDriver(onErrorJustReturn: [])
        }
    }
    
    init(user:String, repo:String) {
        
        //self.view = view;
        self.model = IssueListModel(user: user, repo: repo)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(onIssueRequestCompletedNotification(_:)), name: .IssueRequestCompletedNotification, object: nil)
    }
    
    
    @objc func onIssueRequestCompletedNotification(_ notification: Notification) {
        print("onIssueRequestCompletedNotification IN")
        //self.view.displayIssues(issueItems: model.issues)
    }
    
    func getissuesList() {
        // api request
        // 유저 정보 로딩이 완료되면 리프레쉬되게 
//        self.model.issuesVariable.asObservable().bindTo(issuesReloadSubject).addDisposableTo(disposeBag)
//        self.model.issuesVariable.asDriver()
//        self.model.issuesVariable.asObservable().subscribe(onNext: issueListReload).addDisposableTo(disposeBag)
        self.model.request()
    }
    
//    func issueListReload(issues: [IssueItem]) {
//        self.issuesReloadSubject.onNext(issues)
//    }

    
}
