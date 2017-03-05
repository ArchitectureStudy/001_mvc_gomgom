//
//  IssueListPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 2..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

protocol IssueListPresenterProtocol {
    func displayIssueList()
}

class IssueListPresenter {
    let manager = UserInfoManager.sharedInstance
    
    var router: IssueListRouter!
    var interactor: IssueListInteractor
    var view:IssueListPresenterProtocol!
    
    init(view:IssueListPresenterProtocol) {
        self.view = view
        self.interactor = IssueListInteractor()
    }


}
