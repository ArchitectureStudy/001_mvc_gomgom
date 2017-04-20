//
//  GithubIssueListModel.swift
//  GithubIssues
//
//  Created by leechanggwi on 2017. 3. 27..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import XCTest
import SwiftyJSON
import ObjectMapper
import RxSwift
@testable import GithubIssues

class GithubIssueListModel: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testListModel() {
        let ex = expectation(description: "adsasa")
        
        let userinfo = GitHubUserInfoInteractor()
        let json2 = userinfo.getUserInfo().asObservable().subscribe(onNext: { json in
            let item: IssueItem? = try? Mapper<IssueItem>().map(JSONString: json.stringValue)
            
            let detailModel = IssueDetailModel(user: "lcg5450", repo: "ArchitectureStudy", number: 123123, issueDetail: item!)
            XCTAssertTrue(detailModel.request2())
            
            ex.fulfill()
        })
        
        
        waitForExpectations(timeout: 10) { error in
            print(error.debugDescription)
        }
//        
//        let listDataService = IssueListDataService()
//        let itmes = listDataService.getIssueItems()
//        
        
        
        
    }
    
}
