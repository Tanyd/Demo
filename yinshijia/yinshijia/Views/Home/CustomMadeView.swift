//
//  CustomMadeView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/4.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CustomMadeView: UIView {

    private var didUpdateConstraints = false
    private var moneyImg: UIImageView!
    private var priceLable: UILabel!
    private var unitLable: UILabel!
    private var infoLable: UILabel!
    private var madeButton: buttonNoHighlighted!
    
    convenience init(frame:CGRect,madeButtonClick: ()->()) {
        self.init(frame:frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    private func setUI() {
        backgroundColor = UIColor.colorFromHex(0xf8f8f8)
        self.moneyImg = UIImageView(image: UIImage(named: "rejuPrice"))
        addSubview(self.moneyImg)
        
        self.priceLable = UILabel.lableCutomer("9000-900", fontType: nil, color: Constant.Common.OrangeColor, fontSize: 14)
        addSubview(self.priceLable)
        
        self.unitLable = UILabel.lableCutomer(" /位", fontType: nil, color: UIColor.blackColor(), fontSize: 14)
        addSubview(self.unitLable)
        
        self.infoLable = UILabel.lableCutomer(" dasdsadas", fontType: nil, color: UIColor.lightGrayColor(), fontSize: 12)
        addSubview(self.infoLable)
        
        self.madeButton = buttonNoHighlighted(type: .Custom)
        self.madeButton.backgroundColor = UIColor.colorFromHex(0xfe7c60)
        self.madeButton.setImage(UIImage(named: "custom_icon"), forState: .Normal)
        self.madeButton.setTitle("定制", forState: .Normal)
        self.madeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addSubview(self.madeButton)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            
            self.moneyImg.autoPinEdgeToSuperviewEdge(.Left, withInset: 35.0.fitWidth())
            self.moneyImg.autoAlignAxisToSuperviewAxis(.Horizontal)
            self.moneyImg.autoSetDimensionsToSize(CGSize(width: 40.0.fitWidth(), height: 40.0.fitWidth()))
            
            self.priceLable.autoPinEdge(.Left, toEdge: .Right, ofView: self.moneyImg, withOffset: 17.0.fitWidth())
            self.priceLable.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            self.unitLable.autoPinEdge(.Left, toEdge: .Right, ofView: self.priceLable)
            self.unitLable.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            self.infoLable.autoPinEdge(.Left, toEdge: .Right, ofView: self.unitLable)
            self.infoLable.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            self.madeButton.autoAlignAxisToSuperviewAxis(.Horizontal)
            self.madeButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            self.madeButton.autoSetDimensionsToSize(CGSize(width: 175.0.fitWidth(), height: 65.0.fitHeight()))
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
