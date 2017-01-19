//
//  GithubUserInfoViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit
import p2_OAuth2
import Alamofire

class GithubUserInfoViewController: UIViewController {
    
    fileprivate var alamofireManager: SessionManager?
    
    var loader: OAuth2DataLoader?
    
    var oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "af1c542e34cc2cb919a8",                         // yes, this client-id and secret will work!
        "client_secret": "3bd94893094a92345a93d48076dbb42e9664ea7b",
        "authorize_uri": "https://github.com/login/oauth/authorize",
        "token_uri": "https://github.com/login/oauth/access_token",
        "scope": "user repo:status admin:org",
        "redirect_uris": ["githubissuesapp://oauth/callback"],            // app has registered this scheme
        "secret_in_body": true,                                      // GitHub does not accept client secret in the Authorization header
        "verbose": true,
        ] as OAuth2JSON)

    @IBOutlet var imageView: UIImageView?
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var repoTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var secretKeyTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var issueShowButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func pressedLoginButton(_ sender: UIButton?) {
        /*
        if oauth2.isAuthorizing {
            oauth2.abortAuthorization()
            return
        }
        
        sender?.setTitle("Authorizing...", for: UIControlState.normal)
        
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.authorizeContext = self
        let loader = OAuth2DataLoader(oauth2: oauth2)
        self.loader = loader
        
        loader.perform(request: userDataRequest) { response in
            do {
                let json = try response.responseJSON()
                self.didGetUserdata(dict: json, loader: loader)
            }
            catch let error {
                self.didCancelOrFail(error)
            }
        }
 */
        sender?.setTitle("Authorizing...", for: UIControlState.normal)
        let sessionManager = SessionManager()
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        sessionManager.adapter = retrier
        sessionManager.retrier = retrier
        alamofireManager = sessionManager
        
        sessionManager.request("https://api.github.com/user").validate().responseJSON { response in
            debugPrint(response)
            if let dict = response.result.value as? [String: Any] {
                self.didGetUserdata(dict: dict, loader: nil)
            }
            else {
                self.didCancelOrFail(OAuth2Error.generic("\(response)"))
            }
        }
        sessionManager.request("https://api.github.com/user/repos").validate().responseJSON { response in
            debugPrint(response)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIssueListViewController" {
            
            guard let tempRepo:String = self.repoTextField.text else {
                return
            }
            guard let tempUser:String = self.userTextField.text else {
                return
            }
            guard let tempSecretKey:String = self.secretKeyTextField.text else {
                return
            }
            
            IssueUserInfoManager.sharedInstance.repo = tempRepo
            IssueUserInfoManager.sharedInstance.user = tempUser
            IssueUserInfoManager.sharedInstance.secretKey = tempSecretKey
        }
    }
    
    // MARK: - Actions
    
    var userDataRequest: URLRequest {
        var request = URLRequest(url: URL(string: "https://api.github.com/user")!)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func didGetUserdata(dict: [String: Any], loader: OAuth2DataLoader?) {
        DispatchQueue.main.async {
            if let username = dict["login"] as? String {
                self.usernameTextField?.text = username
            }
            else {
                self.usernameTextField?.text = "(No name found)"
            }
            
            if let imgURL = dict["avatar_url"] as? String, let url = URL(string: imgURL) {
                self.loadAvatar(from: url, with: loader)
            }
            
            self.logoutShowButtons()
        }
    }
    
    func didCancelOrFail(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                print("Authorization went wrong: \(error)")
            }
            self.loginShowButtons()
        }
    }
    
    func loginShowButtons() {
        self.loginButton.isHidden = false
        
        self.logoutButton.isHidden = true
        self.issueShowButton.isHidden = true
        self.infoView.isHidden = true
        self.imageView?.isHidden = true
        self.usernameTextField.isHidden = true
    }
    
    func logoutShowButtons() {
        self.loginButton.isHidden = true
        
        self.logoutButton.isHidden = false
        self.issueShowButton.isHidden = false
        self.infoView.isHidden = false
        self.imageView?.isHidden = false
        self.usernameTextField.isHidden = false
    }

    
    // MARK: - Avatar
    func loadAvatar(from url: URL, with loader: OAuth2DataLoader?) {
        if let loader = loader {
            loader.perform(request: URLRequest(url: url)) { response in
                do {
                    let data = try response.responseData()
                    DispatchQueue.main.async {
                        self.imageView?.image = UIImage(data: data)
                        self.imageView?.isHidden = false
                    }
                }
                catch let error {
                    print("Failed to load avatar: \(error)")
                }
            }
        }
        else {
            alamofireManager?.request(url).validate().responseData() { response in
                if let data = response.result.value {
                    self.imageView?.image = UIImage(data: data)
                    self.imageView?.isHidden = false
                }
                else {
                    print("Failed to load avatar: \(response)")
                }
            }
        }
    }
}
