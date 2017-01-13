//
//  IssueWriteViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 12..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UIViewController {
    func wrapNavigation() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
}

@objc protocol IssueWriteViewControllerDelegate: NSObjectProtocol {
    @objc optional func issueWriteViewControllerDidSave(picker: IssueWriteViewController)
    @objc optional func issueWriteViewControllerDidCancel(picker: IssueWriteViewController)
}


class IssueWriteViewController: UIViewController {
    
    weak var delegate: IssueWriteViewControllerDelegate?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rxAction()
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

extension IssueWriteViewController {
    func rxAction() {
        self.navigationItem.leftBarButtonItem?.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.delegate?.issueWriteViewControllerDidCancel?(picker: self)
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        
        self.navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.delegate?.issueWriteViewControllerDidSave?(picker: self)
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
    }
}
