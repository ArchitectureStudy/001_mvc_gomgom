//
//  IssueListPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 11..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueListPresenterProtocol {
    func displayIssues(issueItems: [IssueItem])
}

class IssueListPresenter {
    
    let model:IssueModel
    var view:IssueListPresenterProtocol!
    
    init(view:IssueListPresenterProtocol) {
        self.view = view;
        self.model = IssueModel(user: "FreeCodeCamp", repo: "FreeCodeCamp")
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueRequestCompletedNotification(_:)), name: .IssueRequestCompletedNotification, object: nil)
    }
    
    
    @objc func onIssueRequestCompletedNotification(_ notification: Notification) {
        print("onIssueRequestCompletedNotification IN")
        self.view.displayIssues(issueItems: model.issues)
    }
    
    func issuesRequest() {
        // api request
        self.model.request()
    }
    
}
