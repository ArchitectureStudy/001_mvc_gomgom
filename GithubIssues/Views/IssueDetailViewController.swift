//
//  IssueDetailViewController.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 12..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class IssueSectionView : IssueDetailCollectionReusableView {
    
}

class IssueCommentCell : IssueCommentCollectionViewCell {
    
}



class IssueDetailViewController: UIViewController {
    
    //리스트에서 선택한 아이템
    var issueSelectedItem:IssueItem = IssueItem()
    
    var presenter: IssueDetailPresenter!
    
    var datasource: Variable<[SectionModel<Int,IssueCommentItem>]> = Variable([SectionModel(model: 1, items:[])])
    let disposeBag = DisposeBag()

    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var detailCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        presenter = IssueDetailPresenter(view: self, selectedItem: issueSelectedItem)
        presenter.issuesRequest()
        
        // collectionView bind Data
        self.bindDataSource()
        self.rxAction()
        
        //if let layout = detailCollectionViewFlowLayout as? UICollectionViewFlowLayout {
        //    detailCollectionViewFlowLayout.estimatedItemSize = CGSize(width: 500, height: 500)
        //}
        
        //detailCollectionViewFlowLayout.estimatedItemSize = CGSize(width: 320, height: 50)
        //self.detailCollectionView.collectionViewLayout = detailCollectionViewFlowLayout;
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
    func displayIssueDetail(issueItem: IssueDetailItem) {
//        usernameLabel.text = issueItem.User.login
//        titleLabel.text = issueItem.body
    }
    
    func displayIssueDetailComments(issueItems: [IssueCommentItem]) {
        let newSectionModel = SectionModel(model: 1, items: issueItems)
        self.datasource.value = [newSectionModel]
    }
}


// MARK: - Rx
extension IssueDetailViewController {
    
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
        
//        self.navigationItem.rightBarButtonItem?.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IssueWriteViewController") as! IssueWriteViewController
//            viewController.delegate = self
//            self?.present(viewController.wrapNavigation(), animated: true, completion: nil)
//            }
//            ).addDisposableTo(disposeBag)
    }
    
    func bindDataSource() {
        datasource.asObservable().bindTo( detailCollectionView.rx.items(dataSource: createDatasource())).addDisposableTo(disposeBag)
    }
    
    func createDatasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueCommentItem>> {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueCommentItem>>()
        
        datasource.configureCell = { datasource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCommentCell", for: indexPath) as? IssueCommentCell else { return IssueCommentCell() }
            cell.usernameLabel.text = item.User.login
            cell.commentLabel.text = item.body
            return cell
        }
                
        datasource.supplementaryViewFactory = { [weak self] (ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "IssueSectionView", for: ip) as! IssueSectionView
            
            guard let weakSelf = self else { return section }
            if ds[ip.section].items.count <= 0 { return section }
            
            
            //ds[ip.section].items[ip.row].User
            
            section.titleLabel.text = weakSelf.issueSelectedItem.body
            section.usernameLabel.text = weakSelf.issueSelectedItem.User.login
            section.commentCountLabel.text = "\(ds[ip.section].items.count) comments"
            
            return section
        }
        
        return datasource
    }
    
    func addCell(text: String) {
        
    }
    
}
