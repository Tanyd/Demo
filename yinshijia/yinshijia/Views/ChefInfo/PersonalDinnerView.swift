//
//  PersonalDinnerView.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class PersonalDinnerView: UIView {

    private var didUpdateConstraints = false
    
    private lazy var dinnerImage: UIImageView = {
        return UIImageView.newAutoLayoutView()
    }()
    
    private lazy var containerView: UIView = {
        return UIView.newAutoLayoutView()
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 15)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: Constant.Common.OrangeColor, fontSize: 15)
        return label
    }()
    
    private lazy var otherInfoLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 12)
        return label
    }()
    
    private lazy var scheduleButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.layer.borderColor = Constant.Common.OrangeColor.CGColor
        btn.layer.borderWidth = 2.0
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: "schedule", forControlEvents: .TouchUpInside)
        btn.setTitle("定制", forState: .Normal)
        return btn
    }()
    
    func schedule() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dinnerImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(otherInfoLabel)
        containerView.addSubview(scheduleButton)
        addSubview(containerView)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        if !didUpdateConstraints {
            dinnerImage.autoSetDimensionsToSize(CGSize(width: 180.0.fitWidth(), height: 180.0.fitWidth()))
            dinnerImage.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            dinnerImage.autoAlignAxisToSuperviewAxis(.Vertical)
            
            containerView.autoPinEdge(.Left, toEdge: .Right, ofView: dinnerImage, withOffset: 30.0.fitWidth())
            containerView.autoPinEdge(.Top, toEdge: .Top, ofView: dinnerImage)
            containerView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: dinnerImage)
            containerView.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            
            titleLabel.autoPinEdgeToSuperviewEdge(.Left)
            titleLabel.autoPinEdgeToSuperviewEdge(.Top)
            
            priceLabel.autoPinEdgeToSuperviewEdge(.Left)
            priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 50.0.fitHeight())
            
            otherInfoLabel.autoPinEdgeToSuperviewEdge(.Bottom)
            otherInfoLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: priceLabel, withOffset: 8.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
