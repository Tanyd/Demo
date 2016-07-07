//
//  ChefInfoSectionHeaderView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/7.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfoSectionHeaderView: UITableViewHeaderFooterView {

    private var didUpdateConstraints = false
    var title: String?{
        didSet{
            titleLabel.text = title
        }
    }
    private lazy var sectionImage: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        img.image = UIImage(named: "sideline_red")
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer("wahah", fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 15)
        label.numberOfLines = 0
        return label
    }()

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(sectionImage)
        contentView.addSubview(titleLabel)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            sectionImage.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(30.0.fitHeight(), 30.0.fitWidth(), 30.0.fitHeight(), 0), excludingEdge: .Right)
            sectionImage.autoSetDimension(.Width, toSize: 15.0.fitWidth())
            
            titleLabel.autoPinEdge(.Top, toEdge: .Top, ofView: sectionImage)
            titleLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: sectionImage)
            titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: sectionImage, withOffset: 25.0.fitWidth())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
