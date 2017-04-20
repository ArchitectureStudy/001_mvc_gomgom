//
//  APIManager.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 16..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON
import ObjectMapper

enum APIManager {
    case requestUserInfo()
    case requestIssues(user: String, repo: String)
    case requestDetailIssue(user: String, repo: String, number: Int)
    case createIssue(user: String, repo: String)
    case createIssueComment(user: String, repo: String, number: Int)
    case requestIssueComments(user: String, repo: String, number: Int)
}

extension APIManager {
    static let BaseURL = "http://api.github.com"
    
    static let requestManager: Alamofire.SessionManager = {
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        defaultHeaders["User-Agent"] = defaultHeaders["User-Agent"]! + appVersion
        //defaultHeaders["Referer"] = "http://ios.afreecatv.com"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.urlCache = nil
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    private func defaultHTTPHeader()->String {
        let executable = Bundle.main.infoDictionary?[kCFBundleExecutableKey as String] as? String ?? "Unknown"
        let os =  UIDevice.current.systemName
        let osversion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        
        return String(format: "%@/%@ (%@; %@ %@; Scale/%f)", arguments:[executable,appVersion,model,os,osversion,UIScreen.main.scale])
    }
    
    fileprivate var urlPath: String {
        switch self {
        case .requestUserInfo:
            return "/user"
        case let .requestIssues(user, repo):
            return "/repos/\(user)/\(repo)/issues"
        case let .requestDetailIssue(user, repo, number):
            return "/repos/\(user)/\(repo)/issues/\(number)"
        case let .createIssue(user, repo):
            return "/repos/\(user)/\(repo)/issues"
        case let .createIssueComment(user, repo, number):
            return "/repos/\(user)/\(repo)/issues/\(number)/comments"
        case let .requestIssueComments(user, repo, number):
            return "/repos/\(user)/\(repo)/issues/\(number)/comments"
        }
    }
    
    fileprivate var method: Alamofire.HTTPMethod {
        switch self {
        case .requestUserInfo,
             .requestIssues,
             .requestDetailIssue,
             .requestIssueComments :
            return .get
        case .createIssue,
             .createIssueComment:
            return .post
        }
    }
    
    fileprivate var url: String {
        return "\(APIManager.BaseURL)\(self.urlPath)"
    }
    
    fileprivate func DefaultHeaders() -> [String: String] {
        switch self.method {
        case .post, .get:
            return ["Authorization": "token \(UserInfoManager.sharedInstance.accessToken)"]
        default:
            return [:]
        }
    }
    
    func buildRequest(_ parameters: [String: Any]? = nil) -> Observable<JSON> {
        
        return Observable.create { observer in
            
            let request = APIManager
                .requestManager
                .request(self.url,
                         method: self.method,
                         parameters: parameters,
                         encoding: JSONEncoding.default,
                         headers: self.DefaultHeaders()).responseSwiftyJSON(
                            completionHandler: { response in
                                switch (response.result, response.response?.statusCode) {
                                case let (.success(json), statusCode) where statusCode! >= 200 && statusCode! < 300:
                                    observer.onNext(json )
                                    observer.onCompleted()
                                case let (.success(_), statusCode):
                                    observer.onError(NSError(domain: "Error", code: statusCode ?? 500, userInfo: ["":""]))
                                case let (.failure(error) , _ ):
                                    observer.onError( error)
                                }
                         })
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

struct APIRequest {
    
    static func getUserInfo() -> Observable<JSON> {
        return APIManager.requestUserInfo().buildRequest()
    }
    
    static func getIssues() -> Observable<[IssueItem]> {
        return APIManager.requestIssues(user: UserInfoManager.sharedInstance.user, repo: UserInfoManager.sharedInstance.repo).buildRequest().map { json -> [IssueItem] in
            let jsonString: String = json.rawString()!
            let issues = try Mapper<IssueItem>().mapArray(JSONString: jsonString)
            return issues
        }
    }
    
//    static func createIssueComment(number: Int, body: String) -> Observable<IssueCommentItem> {
//        let parameters = ["body": body]
//        return APIManager.createIssueComment(user: UserInfoManager.sharedInstance.user, repo: UserInfoManager.sharedInstance.repo, number: number).buildRequest(parameters).flatMap{ json -> Observable<IssueCommentItem> in
//            let jsonString: String = json.rawString()!
//            do {
//                guard let comment = try Mapper<IssueCommentItem>().map(JSONString: jsonString) else {
//                    return Observable.error(NSError(domain: "Error", code: 10011, userInfo: ["":""]))
//                }
//                return Observable.just(comment)
//            } catch {
//                return Observable.error(NSError(domain: "Error", code: 10011, userInfo: ["":""]))
//            }
//        }
//    }
    
    static func createIssueComment(number: Int, body: String) -> Observable<IssueCommentItem> {
        let parameters = ["body": body]
        return APIManager.createIssueComment(user: UserInfoManager.sharedInstance.user, repo: UserInfoManager.sharedInstance.repo, number: number).buildRequest(parameters).map { json -> IssueCommentItem in
            let jsonString: String = json.rawString()!
            let comment = try Mapper<IssueCommentItem>().map(JSONString: jsonString)
            return comment
        }
    }
    
    static func getIssueComments(number: Int) -> Observable<[IssueCommentItem]> {
        return APIManager.requestIssueComments(user: UserInfoManager.sharedInstance.user, repo: UserInfoManager.sharedInstance.repo, number: number).buildRequest().map{ json -> [IssueCommentItem] in
            let jsonString: String = json.rawString()!
            let comments = try Mapper<IssueCommentItem>().mapArray(JSONString: jsonString)
            return comments
        }
    }
}

//class APIManager: NSObject {
//    
//    static let sharedInstance = APIManager()
//    
//    private func defaultHTTPHeaderForSessionManager() -> SessionManager{
//        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
//        defaultHeaders["User-Agent"] = defaultHeaders["User-Agent"]! + appVersion
//        //defaultHeaders["Referer"] = "http://ios.afreecatv.com"
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = defaultHeaders
//        return Alamofire.SessionManager(configuration: configuration)
//    }
//    
//    static let session = APIManager().defaultHTTPHeaderForSessionManager()
//    
//    
//    private func defaultHTTPHeader()->String{
//        
//        
//        let executable = Bundle.main.infoDictionary?[kCFBundleExecutableKey as String] as? String ?? "Unknown"
//        let os =  UIDevice.current.systemName
//        let osversion = UIDevice.current.systemVersion
//        let model = UIDevice.current.model
//        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
//        
//        return String(format: "%@/%@ (%@; %@ %@; Scale/%f)", arguments:[executable,appVersion,model,os,osversion,UIScreen.main.scale])
//    }
//    
//    
//    /// <#Description#>
//    ///
//    /// - Parameters:
//    ///   - methods: <#methods description#>
//    ///   - urlString: <#urlString description#>
//    ///   - parameters: <#parameters description#>
//    ///   - successBlock: <#successBlock description#>
//    ///   - failureBlock: <#failureBlock description#>
//    func requestHTTPTask(_ methods: Alamofire.HTTPMethod, urlString : String, parameters : [String: Any]? = nil , successBlock:@escaping (_ result : AnyObject?) -> Void , failureBlock:@escaping (_ error:NSError) -> Void){
//        
//        APIManager.session.request(urlString, method: methods, parameters: parameters, encoding: URLEncoding.default)
//            .validate(contentType: ["application/json", "text/json", "text/javascript", "text/plain", "text/html", "application/javascript","image/gif"])
//            .responseJSON { response in
//                switch (response.result){
//                case .success:
//                    successBlock(response.result.value as AnyObject?)
//                    break
//                case .failure:
//                    failureBlock(response.result.error! as NSError)
//                    break
//                }
//        }
//    }
//
//}
