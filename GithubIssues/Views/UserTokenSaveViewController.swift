//
//  UserTokenSaveViewController.swift
//  GithubIssues
//
//  Created by MOBDEV on 2017. 2. 3..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit

class UserTokenSaveViewController: UIViewController {

    @IBOutlet weak var tokenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let userDefaults = UserDefaults.standard
        if let accessToken = userDefaults.value(forKey: "accessToken") {
            UserInfoManager.sharedInstance.accessToken = accessToken as! String
        }
        
        if UserInfoManager.sharedInstance.accessToken.length > 0 {
            self.performSegue(withIdentifier: "segueShowRepository", sender: self)
        }
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
    @IBAction func pressedTokenSaveButton(_ sender: Any) {
        guard let tempToken:String = self.tokenTextField.text else {
            return
        }
        
        if tempToken.length > 0 {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(tempToken, forKey: "accessToken")
            userDefaults.synchronize()
            
            UserInfoManager.sharedInstance.accessToken = tempToken
            
            self.performSegue(withIdentifier: "segueShowRepository", sender: self)
        }
    }
    
}
