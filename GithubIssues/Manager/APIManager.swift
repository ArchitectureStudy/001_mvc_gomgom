//
//  APIManager.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 16..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Alamofire

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    private func defaultHTTPHeaderForSessionManager() -> SessionManager{
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        defaultHeaders["User-Agent"] = defaultHeaders["User-Agent"]! + appVersion
        //defaultHeaders["Referer"] = "http://ios.afreecatv.com"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    static let session = APIManager().defaultHTTPHeaderForSessionManager()
    
    
    private func defaultHTTPHeader()->String{
        
        
        let executable = Bundle.main.infoDictionary?[kCFBundleExecutableKey as String] as? String ?? "Unknown"
        let os =  UIDevice.current.systemName
        let osversion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        
        return String(format: "%@/%@ (%@; %@ %@; Scale/%f)", arguments:[executable,appVersion,model,os,osversion,UIScreen.main.scale])
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - methods: <#methods description#>
    ///   - urlString: <#urlString description#>
    ///   - parameters: <#parameters description#>
    ///   - successBlock: <#successBlock description#>
    ///   - failureBlock: <#failureBlock description#>
    func requestHTTPTask(_ methods: Alamofire.HTTPMethod, urlString : String, parameters : [String: Any]? = nil , successBlock:@escaping (_ result : AnyObject?) -> Void , failureBlock:@escaping (_ error:NSError) -> Void){
        
        APIManager.session.request(urlString, method: methods, parameters: parameters, encoding: URLEncoding.default)
            .validate(contentType: ["application/json", "text/json", "text/javascript", "text/plain", "text/html", "application/javascript","image/gif"])
            .responseJSON { response in
                switch (response.result){
                case .success:
                    successBlock(response.result.value as AnyObject?)
                    break
                case .failure:
                    failureBlock(response.result.error! as NSError)
                    break
                }
        }
    }

}
