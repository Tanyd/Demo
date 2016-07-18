//
//  ScheduleTypeCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ScheduleTypeCell: UITableViewCell {

    private var didUpdateConstraints = false
    var items: [Items]?{
        didSet{
            collectionViewH = (ceil(CGFloat((items?.count)!) / CGFloat(3))) * 44
        }
    }
    private var collectionViewH: CGFloat = 0
    private var currentTypeBtn: UIButton?
    
    private lazy var typesCollectionview: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: CGRectZero, collectionViewLayout: flow)
        collectionview.registerClass(TypesCollectionViewCell.self, forCellWithReuseIdentifier: String(TypesCollectionViewCell))
        collectionview.backgroundColor = UIColor.whiteColor()
        collectionview.scrollEnabled = false
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer("选择(单选)", fontType: nil, color: UIColor.lightGrayColor(), fontSize: 15)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel.labelCustomer("999", fontType: nil, color: Constant.Common.OrangeColor, fontSize: 15)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(typesCollectionview)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        if !didUpdateConstraints{
            titleLabel.autoPinEdgeToSuperviewEdge(.Top)
            titleLabel.autoPinEdgeToSuperviewEdge(.Left,withInset: 30.0.fitWidth())
            titleLabel.autoSetDimension(.Height, toSize: 44)
            
            priceLabel.autoPinEdgeToSuperviewEdge(.Top)
            priceLabel.autoPinEdgeToSuperviewEdge(.Right,withInset: 30.0.fitWidth())
            priceLabel.autoSetDimension(.Height, toSize: 44)
            
            typesCollectionview.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel)
            typesCollectionview.autoPinEdgeToSuperviewEdge(.Left)
            typesCollectionview.autoPinEdgeToSuperviewEdge(.Right)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: { 
                typesCollectionview.autoPinEdgeToSuperviewEdge(.Bottom)
            })
            typesCollectionview.autoSetDimension(.Height, toSize: collectionViewH)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension ScheduleTypeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(TypesCollectionViewCell), forIndexPath: indexPath) as? TypesCollectionViewCell
        cell?.type = items![indexPath.item].title
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w = (ScreenSize.SCREEN_WIDTH - 120.0.fitWidth()) / 3
        return CGSize(width: w, height: 44)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 30.0.fitWidth()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 30.0.fitWidth(), 0, 30.0.fitWidth())
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TypesCollectionViewCell
        if currentTypeBtn != nil {
            currentTypeBtn?.selected = false
        }
        cell?.typeButton.selected = true
        currentTypeBtn = cell?.typeButton
        
        for item in items! {
            if item.title == cell?.typeButton.currentTitle {
                priceLabel.text = "\(item.price)"
            }
        }
    }
    
}
