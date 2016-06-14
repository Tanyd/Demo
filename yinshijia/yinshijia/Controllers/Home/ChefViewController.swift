//
//  ChefViewController.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

//MARK: 数据较多时，hot new 切换 有几率导致 悬浮section 飘逸
class ChefViewController: TranslationCollectionViewController {

    private var didUpdateConstraints = false
    private let cellIdentifier = String(ChefCell)
    private let sectionIdentifier = String(ChefSectionView)
    private var bannerView: ChefBannerView!
    private var hotPage = 1
    private var newPage = 1
    private var sectionView: ChefSectionView!
    private var arrayIndex = [NSIndexPath]()
    private var cureentChefType: ChefSectionViewType = .chefHot {
        didSet{
            if newChefListModel.count == 0 || chefModel == nil {
                collectionRefreshHeader()
            }else {
                collectionView!.reloadData()
            }
        }
    }
    
    private var newChefListModel = [Cheflist]() {
        didSet{
            collectionView!.reloadData()
        }
    }
    
    
    private var hotChefListModel = [Cheflist]() {
        didSet{
           chefModel?.data?.chefList! += hotChefListModel
            collectionView!.reloadData()
        }
    }
    private var chefModel: Chef?{
        didSet{
            bannerView.banner.chefBanner = (chefModel?.data?.banner)!
            collectionView!.reloadData()
            collectionView?.hidden = false
            
        }
    }
    init(){
        let layout = XLPlainFlowLayout()
        layout.naviHeight = 0
        layout.itemSize = CGSize(width: 345.0.fitWidth(), height: 530.0.fitHeight())
        layout.minimumLineSpacing = 20.0.fitHeight()
        layout.minimumInteritemSpacing = 20.0.fitWidth()
        layout.sectionInset = UIEdgeInsets(top: 20.0.fitHeight(), left: 20.0.fitWidth(), bottom: 20.0.fitWidth(), right: 20.0.fitWidth())
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        collectionView?.hidden = true
    }

    private func setUI() {
        bannerView = ChefBannerView(frame: CGRectMake(0, -270.fitHeight(), ScreenSize.SCREEN_WIDTH, 270.0.fitHeight()), bannerClick: { (index) in
            DebugPrint("chef banner 点击\(index)")
        })
        collectionView!.addSubview(bannerView)
        collectionView!.contentInset = UIEdgeInsets(top: 270.fitHeight(), left: 0, bottom: 0, right: 0)
        collectionView!.mj_header.ignoredScrollViewContentInsetTop = 270.fitHeight()
        collectionView!.registerClass(ChefCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView!.registerClass(ChefSectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
//        collectionView!.mj_header.beginRefreshing()
        view.setNeedsUpdateConstraints()

    }
    
    override func collectionRefreshHeader() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                self!.collectionView!.mj_header.endRefreshing()
                return
            }
            
            if self!.cureentChefType == .chefHot {
                let model = result as! Chef
                self!.chefModel = model
                self!.hotPage = 1
            }else {
                let model = result as! ChefList
                self!.newChefListModel = model.data!
                self!.newPage = 1
            }
            
            self!.collectionView!.mj_header.endRefreshing()
        }
        
        if cureentChefType == .chefHot {
            Chef.loadChefBaseData(callBack)
        }else{
            ChefList.loadChefListMoreData(callBack, page: 1, type: .chefNew)
        }
        
    }
    
    override func collectionRefreshFooter() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                self!.collectionView!.mj_footer.endRefreshing()
                return
            }
            
            if self!.cureentChefType == .chefHot {
                let model = result as! ChefList
                self!.hotChefListModel = model.data!
            }else {
                let model = result as! ChefList
                if self!.newChefListModel.count == 0 {
                    self!.newChefListModel = model.data!
                }else{
                    self!.newChefListModel += model.data!
                }
            }
            
            self!.collectionView!.mj_footer.endRefreshing()
        }
        
        if cureentChefType == .chefHot {
            ChefList.loadChefListMoreData(callBack, page: hotPage, type: .chefHot)
        }else{
            ChefList.loadChefListMoreData(callBack, page: newPage, type: .chefNew)
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cureentChefType == .chefNew {
            return newChefListModel.count ?? 0
        }else {
            return chefModel?.data?.chefList?.count ?? 0
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChefCell
        cell.type = .chefType
        var model: Cheflist?
        if cureentChefType == .chefNew {
            model = newChefListModel[indexPath.item]
            cell.chefModel = model!
        }else {
            model = chefModel?.data?.chefList![indexPath.item]
            cell.chefModel = chefModel?.data?.chefList![indexPath.item]
        }
        
        if (collectionView.dragging || collectionView.decelerating) && !(arrayIndex.contains(indexPath)){
            
            cell.icon.sd_setImageWithURL(nil, placeholderImage: UIImage(named: "wutu"))
            
        }else {
            cell.icon.sd_setImageWithURL(NSURL(string: model!.imageurl!), placeholderImage: UIImage(named: "wutu"), completed: { (img, error, _, url) in
                
                if !self.arrayIndex.contains(indexPath) {
                    self.arrayIndex.append(indexPath)
                }
            })
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        sectionView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: sectionIdentifier, forIndexPath: indexPath) as! ChefSectionView
        sectionView.chefBtnClick = {(chefType) in
            if chefType == .chefHot{
                self.cureentChefType = .chefHot
            }else{
                self.cureentChefType = .chefNew
            }
        }
        collectionView.bringSubviewToFront(sectionView)
        return sectionView
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(ScreenSize.SCREEN_WIDTH, 85.fitHeight())
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ChefCell
        DebugPrint("chef cell  点击\(cell.tag)")
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            downloadImg()
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        downloadImg()
    }
    
    private func  downloadImg() {
        let visibleRows = collectionView!.indexPathsForVisibleItems()
        var newRows = [NSIndexPath]()
        for path in visibleRows {
            if !self.arrayIndex.contains(path) {
                newRows.append(path)
            }
        }
        collectionView!.reloadItemsAtIndexPaths(newRows)
    }
}

