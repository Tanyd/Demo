//
//  TypesCollectionViewCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class TypesCollectionViewCell: UICollectionViewCell {
    
    private var didUpdateConstraints = false
    var type: String?{
        didSet{
            typeButton.setTitle(type, forState: .Normal)
        }
    }
    
    lazy var typeButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setBackgroundImage(UIImage.imageWithColor(UIColor.colorFromHex(0xf5f5f5)), forState: .Normal)
        btn.setBackgroundImage(UIImage.imageWithColor(Constant.Common.OrangeColor), forState: .Selected)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        btn.layer.cornerRadius = 5.0
        btn.titleLabel?.textAlignment = .Center
        btn.userInteractionEnabled = false
//        btn.addTarget(self, action: "typeSelected:", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    func typeSelected(sender: UIButton) {
        sender.selected = !sender.selected
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(typeButton)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            typeButton.autoPinEdgeToSuperviewEdge(.Left)
            typeButton.autoPinEdgeToSuperviewEdge(.Right)
            typeButton.autoPinEdgeToSuperviewEdge(.Top, withInset: 20.0.fitHeight())
            typeButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 20.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
}
