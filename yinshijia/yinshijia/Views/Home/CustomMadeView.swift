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
    var model: Baseinfo? {
        didSet{
            priceLable.text = "\(model!.price)-\(model!.max_price)"
            unitLable.text = " /\(model!.unit!)"
            infoLable.text = " (\(model!.people_count)\(model!.unit!)起订)"
        }
    }
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
        moneyImg = UIImageView(image: UIImage(named: "rejuPrice"))
        addSubview(moneyImg)
        
        priceLable = UILabel.lableCutomer(nil, fontType: nil, color: Constant.Common.OrangeColor, fontSize: 14)
        addSubview(priceLable)
        
        unitLable = UILabel.lableCutomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 14)
        addSubview(unitLable)
        
        infoLable = UILabel.lableCutomer(nil, fontType: nil, color: UIColor.lightGrayColor(), fontSize: 12)
        addSubview(infoLable)
        
        madeButton = buttonNoHighlighted(type: .Custom)
        madeButton.backgroundColor = UIColor.colorFromHex(0xfe7c60)
        madeButton.setImage(UIImage(named: "custom_icon"), forState: .Normal)
        madeButton.setTitle("定制", forState: .Normal)
        madeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addSubview(madeButton)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            
            moneyImg.autoPinEdgeToSuperviewEdge(.Left, withInset: 35.0.fitWidth())
            moneyImg.autoAlignAxisToSuperviewAxis(.Horizontal)
            moneyImg.autoSetDimensionsToSize(CGSize(width: 40.0.fitWidth(), height: 40.0.fitWidth()))
            
            priceLable.autoPinEdge(.Left, toEdge: .Right, ofView: moneyImg, withOffset: 17.0.fitWidth())
            priceLable.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            unitLable.autoPinEdge(.Left, toEdge: .Right, ofView: priceLable)
            unitLable.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            infoLable.autoPinEdge(.Left, toEdge: .Right, ofView: unitLable)
            infoLable.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            madeButton.autoAlignAxisToSuperviewAxis(.Horizontal)
            madeButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            madeButton.autoSetDimensionsToSize(CGSize(width: 175.0.fitWidth(), height: 65.0.fitHeight()))
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
