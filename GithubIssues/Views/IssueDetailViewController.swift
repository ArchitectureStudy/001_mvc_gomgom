//
//  IssueDetailViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 12..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    //리스트에서 선택한 아이템
    var issueSelectedItem:IssueItem = IssueItem()
    
    var presenter: IssueDetailPresenter!

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        presenter = IssueDetailPresenter(view: self, selectedItem: issueSelectedItem)
        presenter.issuesRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.title = "#\(issueSelectedItem.number)"
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

}

extension IssueDetailViewController: IssueDetailPresenterProtocol {
    func displayDetailIssue(issueItem: IssueDetailItem) {
        idTextField.text = issueItem.User.login
        bodyTextView.text = issueItem.body
    }
}
