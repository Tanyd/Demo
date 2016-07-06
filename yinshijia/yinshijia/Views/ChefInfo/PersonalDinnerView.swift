//
//  PersonalDinnerView.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class PersonalDinnerView: UITableViewCell {
    
    private var didUpdateConstraints = false
    enum PersonalDinnerViewType: Int {
        case PersonalDinner
        case ChefMade
    }
    
    var cellType: PersonalDinnerViewType?{
        didSet{
            if cellType == .PersonalDinner {
                otherInfoLabel.hidden = false
            }else{
                otherInfoLabel.hidden = true
            }
        }
    }
    
    var personalDinnerModel: Themedinner?{
        didSet{
            
        }
    }
    
    var chefMadeModel: ChefInfoGoods?{
        didSet{
            
        }
    }
    
    private var scheduleAction: ((id: String)->())?
    
    private lazy var dinnerImage: UIImageView = {
        return UIImageView.newAutoLayoutView()
    }()
    
    private lazy var containerView: UIView = {
        return UIView.newAutoLayoutView()
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 15)
        label.numberOfLines = 0
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
        btn.addTarget(self, action: "schedule:", forControlEvents: .TouchUpInside)
        btn.setTitle("定制", forState: .Normal)
        return btn
    }()
    
    func schedule(sender: UIButton) {
        if scheduleAction != nil {
            scheduleAction!(id: String(scheduleButton))
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(otherInfoLabel)
        containerView.addSubview(scheduleButton)
        contentView.addSubview(containerView)
        contentView.addSubview(dinnerImage)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        if !didUpdateConstraints {
            dinnerImage.autoSetDimensionsToSize(CGSize(width: 180.0.fitWidth(), height: 180.0.fitWidth()))
            dinnerImage.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            dinnerImage.autoPinEdgeToSuperviewEdge(.Top)
            
            containerView.autoPinEdge(.Left, toEdge: .Right, ofView: dinnerImage, withOffset: 30.0.fitWidth())
            containerView.autoPinEdge(.Top, toEdge: .Top, ofView: dinnerImage)
            containerView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: dinnerImage)
            containerView.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            
            titleLabel.autoPinEdgeToSuperviewEdge(.Left)
            titleLabel.autoPinEdgeToSuperviewEdge(.Top)
            titleLabel.autoPinEdgeToSuperviewEdge(.Right)
            
            scheduleButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            scheduleButton.autoPinEdgeToSuperviewEdge(.Bottom)
            
            if cellType == .PersonalDinner {
                priceLabel.autoPinEdgeToSuperviewEdge(.Left)
                priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 50.0.fitHeight())
                
                otherInfoLabel.autoPinEdgeToSuperviewEdge(.Bottom)
                otherInfoLabel.autoPinEdgeToSuperviewEdge(.Left)
                otherInfoLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: priceLabel, withOffset: 8.0.fitHeight())
            }else{
                priceLabel.autoPinEdgeToSuperviewEdge(.Left)
                priceLabel.autoPinEdgeToSuperviewEdge(.Bottom)
            }
            
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
