//
//  GithubUserInfoViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 14..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit

class GithubUserInfoViewController: UIViewController {

    @IBOutlet weak var repoTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var secretKeyTextField: UITextField!
    
    
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
}
