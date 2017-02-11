//
//  ViewModel.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 10..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

class ViewModel: NSObject, ViewModelProtocol {
    
    let services: ViewModelServicesProtocol
    
    init(services: ViewModelServicesProtocol) {
        self.services = services
        super.init()
    }
}
