//
//  GitHubUserInfoPresenter.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 3..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

protocol GitHubUserInfoPresenterProtocol {
    func displayUserInfo(userInfo: JSON)
}

class GitHubUserInfoPresenter {
    
    let manager = UserInfoManager.sharedInstance
    
    var router: GitHubUserInfoRouter?
    var interactor: GitHubUserInfoInteractor
    var view:GitHubUserInfoPresenterProtocol!
    
    init(view:GitHubUserInfoPresenterProtocol) {
        self.view = view
        self.interactor = GitHubUserInfoInteractor()
    }
    
    func getUserInfo() -> Observable<JSON> {
        return self.interactor.getUserInfo()
    }
    
    func pressedTokenDeleteButton() {
        self.router?.showTokenInputButton()
    }
}
