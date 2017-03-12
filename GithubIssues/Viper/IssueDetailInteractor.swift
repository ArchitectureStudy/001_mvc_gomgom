//
//  IssueDetailInteractor.swift
//  GithubIssues
//
//  Created by leechanggwi on 2017. 3. 13..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

class IssueDetailInteractor {
    
    let manager = UserInfoManager.sharedInstance
    
    //리스트에서 선택한 아이템
    var issueSelectedItem:IssueItem!
    
    var disposeBag = DisposeBag()
    var viewModel: IssueDetailViewModel!
    var dataService: IssueListDataService!
    
    init(user: String, repo: String, selectedItem:IssueItem) {
        viewModel = IssueDetailViewModel(user: user, repo: repo, selectedItem:selectedItem)
        dataService = IssueListDataService()
        issueSelectedItem = selectedItem
    }
    
    func issueRquest() {
        self.viewModel.modelComment.issueCommentsVariable.asObservable().subscribe(onNext: issueCommentReload).addDisposableTo(disposeBag)
        APIRequest.getIssueComments(number: self.issueSelectedItem.number)
            .bindTo(self.viewModel.modelComment.issueCommentsVariable)
            .addDisposableTo(disposeBag)
    }
    
    func issueCommentReload(comments: [IssueCommentItem]) {
        //self.view.displayIssueDetailComments(commentItems: self.modelComment.issueCommentsVariable.value)
//        self.issuesCommentReloadSubject.onNext(comments)
        
        let issueListDataDict:[String: [Any]] = ["issueCommentsData": comments]
        NotificationCenter.default.post(name: Notification.Name.Interactor.detailCommentsRequestComplete, object: self.viewModel, userInfo: issueListDataDict)
    }
}
