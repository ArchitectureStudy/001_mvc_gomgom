//
//  GithubUserInfoViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import SwiftyJSON
import ObjectMapper
import SDWebImage


class GithubUserInfoViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    let userInfoVariable: Variable<JSON> = Variable<JSON>([])
    let userInfoSubject: PublishSubject<JSON> = PublishSubject<JSON>()
    
    var setUserInfo:UserInfoItem = UserInfoItem()
    let avatarurl: String = ""

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
        
        // 유저 정보 로딩이 완료되면 리프레쉬되게
        userInfoVariable.asObservable().subscribe(onNext: userInfoReload).addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.logoutShowButtons()
        
        // 유저 정보 읽어오기
        APIRequest.getUserInfo().bindTo(userInfoVariable).addDisposableTo(disposeBag)
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
    
    @IBAction func pressedTokenRemoveButton(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "accessToken")
        userDefaults.synchronize()
        
        UserInfoManager.sharedInstance.accessToken = ""
        
        self.performSegue(withIdentifier: "sequeShowUserTokenViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
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
            IssueUserInfoManager.sharedInstance.accessToken = tempSecretKey
        }
        
        if segue.identifier == "sequeShowUserTokenViewController" {
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "accessToken")
            userDefaults.synchronize()
        }
 */
    }
    
    // MARK: - Actions
    func loginShowButtons() {
        self.logoutButton.isHidden = true
        self.issueShowButton.isHidden = true
        self.infoView.isHidden = true
        self.imageView?.isHidden = true
        self.usernameTextField.isHidden = true
    }
    
    func logoutShowButtons() {
        self.logoutButton.isHidden = false
        self.issueShowButton.isHidden = false
        self.infoView.isHidden = false
        self.imageView?.isHidden = false
        self.usernameTextField.isHidden = false
    }

    func userInfoReload(userInfo: JSON) {
//        let issues = self.issuesVariable.value
//        let newIssues = issues.map { issue -> Issue in
//            if issue.number == oldIssue.number {
//                return newIssue
//            }
//            return issue
//        }
//        self.issuesVariable.value = newIssues
        print("Failed to load avatar: \(userInfo)")
        print("Failed to load avatar: \(userInfo)")
        
        print("avatar : \(userInfo["avatar_url"])")
        
        if let dictionary = userInfo.dictionaryObject {
            if let avatarurl = dictionary["avatar_url"] as? String {
                // access individual value in dictionary
                let url = URL(string: avatarurl)
                self.imageView?.sd_setImage(with: url)
            }
            
            if let username = dictionary["name"] as? String {
                self.usernameTextField.text = username
            }
        }
    }
}


class UserInfoItem:Mappable {
    
    var avatarurl:String = ""

    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        avatarurl <- map["avatar_url"]
    }
}
