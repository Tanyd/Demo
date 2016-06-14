//
//  MarketViewController.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MarketViewController: TranslationCollectionViewController {

    private var didUpdateConstraints = false
    private let cellIdentifier = String(ChefCell)
    private var page = 1
    private var arrayIndex = [NSIndexPath]()
    private var goodsList = [GoodsData](){
        didSet{
            collectionView!.reloadData()
        }
    }
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 345.0.fitWidth(), height: 500.0.fitHeight())
        layout.minimumLineSpacing = 20.0.fitHeight()
        layout.minimumInteritemSpacing = 20.0.fitWidth()
        layout.sectionInset = UIEdgeInsets(top: 20.0.fitHeight(), left: 20.0.fitWidth(), bottom: 20.0.fitWidth(), right: 20.0.fitWidth())
        super.init(collectionViewLayout: layout)
    }
    
    private func setUI() {
        collectionView!.registerClass(ChefCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView!.mj_header.beginRefreshing()
        view.setNeedsUpdateConstraints()
        
    }
    
    override func collectionRefreshHeader() {
        page = 1
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                self!.collectionView!.mj_header.endRefreshing()
                return
            }
            self!.goodsList = (result as? Goods)!.data!
            self!.collectionView!.mj_header.endRefreshing()
        }
        Goods.loadGoodsData(callBack, page: 1)
    }
    
    override func collectionRefreshFooter() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                self!.collectionView!.mj_footer.endRefreshing()
                return
            }
            self!.goodsList += (result as? Goods)!.data!
            self!.collectionView!.mj_footer.endRefreshing()
        }
        ++page
        Goods.loadGoodsData(callBack, page: page)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsList.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChefCell
        cell.type = .goodsType
        let model = goodsList[indexPath.item]
        cell.goodsModel = model
        if (collectionView.dragging || collectionView.decelerating) && !(arrayIndex.contains(indexPath)){
            cell.icon.sd_setImageWithURL(nil, placeholderImage: UIImage(named: "wutu"))
        }else {
            cell.icon.sd_setImageWithURL(NSURL(string: model.properties_image!), placeholderImage: UIImage(named: "wutu"), completed: { (img, error, _, url) in
                
                if !self.arrayIndex.contains(indexPath) {
                    self.arrayIndex.append(indexPath)
                }
            })
        }
        
        return cell
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
