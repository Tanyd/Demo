//
//  CollectionViewController.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/12.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TranslationCollectionViewController: UICollectionViewController {

    var oldOffYes: CGFloat = 0
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = UIColor.colorFromHex(0xffffff)
        setupRefresh()
    }
    
    private func setupRefresh(){
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "collectionRefreshHeader")
        collectionView!.mj_header = header
        let footer = MJRefreshBackStateFooter(refreshingTarget: self, refreshingAction: "collectionRefreshFooter")
        footer.setTitle("没有更多数据", forState: MJRefreshState.NoMoreData)
        collectionView!.mj_footer = footer

    }
    
    func collectionRefreshHeader() {

    }
    
    func collectionRefreshFooter() {
    }
    
    func endRefresh() {
        collectionView!.mj_footer.endRefreshing()
        collectionView!.mj_header.endRefreshing()
    }
    
    func endRefreshWithoutData() {
        collectionView!.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func resetNoMoreData() {
        collectionView!.mj_footer.resetNoMoreData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
         NSNotificationCenter.defaultCenter().postNotificationName(BaseTranslationViewControllerNotification.NotificationName, object: nil, userInfo: [BaseTranslationViewControllerNotification.CurrentOffY:scrollView.contentOffset.y,BaseTranslationViewControllerNotification.OldOffY:oldOffYes])
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        oldOffYes = scrollView.contentOffset.y
    }
  
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
