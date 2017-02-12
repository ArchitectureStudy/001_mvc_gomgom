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
import AlamofireImage


class IssueSectionView : IssueDetailCollectionReusableView {
    
}

class IssueCommentCell : IssueCommentCollectionViewCell {
    
}


class IssueDetailViewController: UIViewController {
    
    //리스트에서 선택한 아이템
    var issueSelectedItem:IssueItem!
    
    var presenter: IssueDetailViewModel!
    
    var datasource: Variable<[SectionModel<Int,IssueCommentItem>]> = Variable([SectionModel(model: 1, items:[])])
    let disposeBag = DisposeBag()

    @IBOutlet weak var writeCommentTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var detailCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        presenter = IssueDetailViewModel(view: self, selectedItem: issueSelectedItem)
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

extension IssueDetailViewController: IssueDetailViewModelProtocol {
    func displayIssueDetail(issueItem: IssueItem) {
        self.detailCollectionView.reloadData()
    }
    
    func displayIssueDetailComments(commentItems: [IssueCommentItem]) {
        let newSectionModel = SectionModel(model: 1, items: commentItems)
        self.datasource.value = [newSectionModel]
        
        DispatchQueue.main.async {
            self.writeCommentTextField.text = ""
            
            if self.detailCollectionView.contentSize.height > self.detailCollectionView.frame.size.height {
                let size:CGSize = self.detailCollectionView.contentSize
                let newOffSet =  CGPoint(x: 0, y: (size.height) - (self.detailCollectionView.frame.height))
                self.detailCollectionView.setContentOffset(newOffSet, animated: true)
            }
            
            NotificationCenter.default.post(name: .IssueWriteCommentsRequestCompletedNotification, object: nil)
        }
    }
    
    func displayIssueWriteComments(issueItems: [IssueCommentItem]) {
        let newSectionModel = SectionModel(model: 1, items: issueItems)
        self.datasource.value = [newSectionModel]
        
        //self.issueSelectedItem.comments = issueItems.count
    }
}


// MARK: - Rx
extension IssueDetailViewController {
    
    func rxAction() {
        /*
        detailCollectionView.rx.observe(CGSize.self, "contentSize")
            .filter{ size -> Bool in
                size?.height != 0
            }
            .distinctUntilChanged{ (old,new) -> Bool in
                return (old?.width == new?.width && old?.height == new?.height)
            }
            .skip(1)
            .subscribe(onNext: { [weak self] size in
                let newOffSet =  CGPoint(x: 0, y: (size?.height ?? 0) - (self?.detailCollectionView.frame.height ?? 0))
                self?.detailCollectionView.setContentOffset(newOffSet, animated: true)
            }).addDisposableTo(disposeBag)*/
        
        self.saveButton.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self else { return }
                weakSelf.presenter.writeComment(comment: weakSelf.writeCommentTextField.text!)
            }
            ).addDisposableTo(disposeBag)
    }
    
    func bindDataSource() {
        datasource.asObservable().bindTo( detailCollectionView.rx.items(dataSource: createDatasource())).addDisposableTo(disposeBag)
    }
    
    func createDatasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueCommentItem>> {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int,IssueCommentItem>>()
        
        datasource.configureCell = { datasource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCommentCell", for: indexPath) as? IssueCommentCell else { return IssueCommentCell() }
            let url = URL(string: item.user.avatar_url)!
            let placeholderImage = UIImage(named: "placeholder")!
            cell.profileThumbnail.af_setImage(withURL: url, placeholderImage: placeholderImage)
            cell.usernameLabel.text = item.user.login
            cell.commentLabel.text = item.body
            return cell
        }
                
        datasource.supplementaryViewFactory = { [weak self] (ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "IssueSectionView", for: ip) as! IssueSectionView
            
            guard let weakSelf = self else { return section }
            if ds[ip.section].items.count <= 0 { return section }
            
            
            //ds[ip.section].items[ip.row].User
            
            section.titleLabel.text = weakSelf.issueSelectedItem.body
            section.usernameLabel.text = weakSelf.issueSelectedItem.user.login
            section.commentCountLabel.text = "\(ds[ip.section].items.count) comments"
            
            return section
        }
        
        return datasource
    }
    
    func addCell(text: String) {
        
    }
    
}
