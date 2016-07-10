//
//  MenuHeaderCollectionViewCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MenuHeaderCollectionViewCell: UICollectionViewCell {
    
    private var didUpdateConstraints = false
    var menu: Catalogs?{
        didSet{
            tag = (menu?.catalogId)!
            dinnerImage.sd_setImageWithURL(NSURL(string: (menu?.catalogImage)!), placeholderImage: nil)
            titleLabel.text = menu?.catalogTitle
        }
    }
    private lazy var dinnerImage: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        img.aliCornerRadius = 100.0.fitHeight() * 0.5
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(dinnerImage)
        contentView.addSubview(titleLabel)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            dinnerImage.autoSetDimensionsToSize(CGSize(width: 100.0.fitWidth(), height: 100.0.fitWidth()))
            dinnerImage.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(18.0.fitHeight(), 30.0.fitWidth(), 0, 30.0.fitWidth()), excludingEdge: .Bottom)
            
            titleLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: dinnerImage, withOffset: 15.0.fitHeight())
            titleLabel.autoPinEdgeToSuperviewEdge(.Bottom,withInset: 10.0.fitHeight())
            
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
