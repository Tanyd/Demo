//
//  MenuHeaderView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/8.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MenuHeaderView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var menus = [Catalogs](){
        didSet{
            reloadData()
        }
    }
    
    init(frame: CGRect){
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.whiteColor()
        registerClass(MenuHeaderCollectionViewCell.self, forCellWithReuseIdentifier: String(MenuHeaderCollectionViewCell))
        delegate = self
        dataSource = self
        scrollEnabled = false
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(MenuHeaderCollectionViewCell), forIndexPath: indexPath) as? MenuHeaderCollectionViewCell
        cell?.menu = menus[indexPath.item]
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 160.0.fitWidth(), height: 164.0.fitHeight())
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
  
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(25.0.fitHeight(), 25.0.fitWidth(), 25.0.fitHeight(), 25.0.fitWidth())
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        print(collectionView.cellForItemAtIndexPath(indexPath)?.tag)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
