
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
    
    
    var presenter: IssueListPresenter!
    
    var datasource: Variable<[SectionModel<Int,IssueListItem>]> = Variable([SectionModel(model: 1, items:[])])
    let disposeBag = DisposeBag()

    @IBOutlet weak var issueCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = IssueListPresenter(view: self)
        presenter.issuesRequest()

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
    
    func createDatasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueListItem>> {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueListItem>>()
        
        datasource.configureCell = { datasource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCollectionViewCell", for: indexPath) as? IssueCollectionViewCell else { return IssueCollectionViewCell() }
            cell.issueNumber = "#\(item.number)"
            cell.issueTitle = "\(item.title)"
            return cell
        }
        return datasource
    }
    
    func addCell(text: String) {
        
    }
}



extension IssueListViewController:IssueListPresenterProtocol {
    func displayIssues(issueItems: [IssueListItem]) {
        let newSectionModel = SectionModel(model: 1, items: issueItems)
        self.datasource.value = [newSectionModel]
    }
}

extension IssueListViewController: IssueWriteViewControllerDelegate {
    func memoGetController(picker: IssueWriteViewController) {
//        addCell(text: memo)
    }
    
    func memoGetControllerDidCancel(picker: IssueWriteViewController) {
        
    }
}

