
//
//  IssueListViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 6..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class IssueListViewController: UIViewController {
    
    let model = IssueModel(user: "FreeCodeCamp", repo: "FreeCodeCamp")
    
    var datasource: Variable<[SectionModel<Int,String>]> = Variable([SectionModel(model: 1, items:["이슈를 읽어오고 있습니다."])])
    let disposeBag = DisposeBag()

    @IBOutlet weak var issueCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueRequestCompletedNotification(_:)), name: IssueRequestCompletedNotification, object: nil)
        
        // api request
        model.request()
        
        // collectionView bind Data
        self.bindDataSource()
        self.rxAction()
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
    
    
    func onIssueRequestCompletedNotification(_ notification: Notification) {
        print("onIssueRequestCompletedNotification IN")
        let newSectionModel = SectionModel(model: 1, items: model.issues)
        self.datasource.value = [newSectionModel]
    }

}


// MARK: - Rx
extension IssueListViewController {
    
    func rxAction() {
        issueCollectionView.rx.observe(CGSize.self, "contentSize")
            .filter{ size -> Bool in
                size?.height != 0
            }
            .distinctUntilChanged{ (old,new) -> Bool in
                return (old?.width == new?.width && old?.height == new?.height)
            }
            .skip(1)
            .subscribe(onNext: { [weak self] size in
                let newOffSet =  CGPoint(x: 0, y: (size?.height ?? 0) - (self?.issueCollectionView.frame.height ?? 0))
                self?.issueCollectionView.setContentOffset(newOffSet, animated: true)
            }).addDisposableTo(disposeBag)
    }
    
    func bindDataSource() {
        datasource.asObservable().bindTo( issueCollectionView.rx.items(dataSource: createDatasource())).addDisposableTo(disposeBag)
    }
    
    func createDatasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int,String>> {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int,String>>()
        
        datasource.configureCell = { datasource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCollectionViewCell", for: indexPath) as? IssueCollectionViewCell else { return IssueCollectionViewCell() }
            cell.issueLabel.text = "\(item)"
            return cell
        }
        return datasource
    }
    
    func addCell(text: String) {
        
    }
}

