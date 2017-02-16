
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
    
    @IBOutlet weak var issueAddButton: UIBarButtonItem!
    @IBOutlet weak var memoCountLabel: UILabel!
    
    let manager = UserInfoManager.sharedInstance
    
    var viewModel: IssueListViewModel!
    
    let disposeBag = DisposeBag()
    var datasource: Variable<[SectionModel<Int,IssueItem>]> = Variable([SectionModel(model: 1, items:[])])
    //let issuesSaveSubject: PublishSubject<(IssueItem, IssueItem)> = PublishSubject<(IssueItem, IssueItem)>()
    
    @IBOutlet weak var issueCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = IssueListViewModel(user: manager.user, repo: manager.repo)
        viewModel.getissuesList()

        // collectionView bind Data
        self.bindDataSource()
        self.rxAction()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onIssueWriteCommentsRequestCompletedNotification(_:)), name: .IssueWriteCommentsRequestCompletedNotification, object: nil)
        
        
        viewModel.issuesReloadSubject.subscribe(onNext: displayIssues).addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func displayIssues(issueItems: [IssueItem]) {
        let newSectionModel = SectionModel(model: 1, items: issueItems)
        self.datasource.value = [newSectionModel]
    }
    
    func savedIssue(oldIssue: IssueItem, newIssue: IssueItem) {
        print("savedIssue IN")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onIssueWriteCommentsRequestCompletedNotification(_ notification: Notification) {
        print("onIssueDetailCommentsRequestCompletedNotification R IN")
        //self.issueCollectionView.reloadData()
        viewModel.getissuesList()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func changeIssue(oldIssue: IssueItem, newIssue: IssueItem) {
        /*
        let issues = datasource.value.first?.items
        let newIssues = issues.map { issue -> IssueItem in
            if issue.number == oldIssue.number {
                return newIssue
            }
            return issue
        }
        self.issuesVariable.value = newIssues
        */
        
        self.issueCollectionView.reloadData()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIssueDetailViewController", let destination = segue.destination as? IssueDetailViewController {
            
            if let cell = sender as? IssueCollectionViewCell, let indexPath = issueCollectionView.indexPath(for: cell) {
                let affiliation = datasource.value.first?.items[indexPath.row]
                destination.issueSelectedItem = affiliation!
            }
        }
    }
    
    
}


// MARK: - Rx
extension IssueListViewController {
    
    func rxAction() {
//        issueCollectionView.rx.observe(CGSize.self, "contentSize")
//            .filter{ size -> Bool in
//                size?.height != 0
//            }
//            .distinctUntilChanged{ (old,new) -> Bool in
//                return (old?.width == new?.width && old?.height == new?.height)
//            }
//            .skip(1)
//            .subscribe(onNext: { [weak self] size in
//                let newOffSet =  CGPoint(x: 0, y: (size?.height ?? 0) - (self?.issueCollectionView.frame.height ?? 0))
//                self?.issueCollectionView.setContentOffset(newOffSet, animated: true)
//            }).addDisposableTo(disposeBag)
        
        self.navigationItem.rightBarButtonItem?.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IssueWriteViewController") as! IssueWriteViewController
            viewController.delegate = self
            self?.present(viewController.wrapNavigation(), animated: true, completion: nil)
            }
            ).addDisposableTo(disposeBag)
    }
    
    func bindDataSource() {
        datasource.asObservable().bindTo( issueCollectionView.rx.items(dataSource: createDatasource())).addDisposableTo(disposeBag)
    }
    
    func createDatasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueItem>> {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueItem>>()
        
        datasource.configureCell = { datasource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCollectionViewCell", for: indexPath) as? IssueCollectionViewCell else { return IssueCollectionViewCell() }
            
            cell.configure(withDelegate: IssueCellViewModel(item: item))
            
            return cell
        }
        return datasource
    }
    
    func addCell(text: String) {
        
    }
}


/*
extension IssueListViewController:IssueListViewModelProtocol {
    func displayIssues(issueItems: [IssueItem]) {
        let newSectionModel = SectionModel(model: 1, items: issueItems)
        self.datasource.value = [newSectionModel]
    }
}*/

extension IssueListViewController: IssueWriteViewControllerDelegate {
    func memoGetController(picker: IssueWriteViewController) {
//        addCell(text: memo)
    }
    
    func memoGetControllerDidCancel(picker: IssueWriteViewController) {
        
    }
}

