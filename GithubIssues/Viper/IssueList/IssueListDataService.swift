//
//  IssueListDataService.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 3. 2..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class IssueListDataService {

    func getIssueItems() -> Observable<[IssueItem]> {
        return APIRequest.getIssues()
    }
}
