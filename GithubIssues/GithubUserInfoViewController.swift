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
    
    var presenter: GitHubUserInfoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let presenter = GitHubUserInfoPresenter(view: self)
        self.presenter = presenter
        presenter.router = GitHubUserInfoRouter(viewController: self, navigationController: self.navigationController)
        
        // 유저 정보 로딩이 완료되면 리프레쉬되게
        userInfoVariable.asObservable().subscribe(onNext: userInfoReload).addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.logoutShowButtons()
        
        // 유저 정보 읽어오기
        self.presenter.getUserInfo().bindTo(userInfoVariable).addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
        self.presenter.showTokenInputTextField()
    }
    
    /*
     이 화면이동 segue를 어떻게 처리해야 할까...
     버튼의 이벤트를 받아서 수동으로만 처리해야 하나...
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIssueListViewController" {
            guard let tempRepo:String = self.repoTextField.text else {
                return
            }
            guard let tempUser:String = self.userTextField.text else {
                return
            }
            UserInfoManager.sharedInstance.repo = tempRepo
            UserInfoManager.sharedInstance.user = tempUser
        }
        
        self.presenter.prepare(for: segue, sender: sender)
    }
    
    func logoutShowButtons() {
        self.logoutButton.isHidden = false
        self.issueShowButton.isHidden = false
        self.infoView.isHidden = false
        self.imageView?.isHidden = false
        self.usernameTextField.isHidden = false
    }
    
    func userInfoReload(userInfo: JSON) {
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

extension GithubUserInfoViewController: GitHubUserInfoPresenterProtocol {
    func displayUserInfo(userInfo: JSON) {
        
    }
}
