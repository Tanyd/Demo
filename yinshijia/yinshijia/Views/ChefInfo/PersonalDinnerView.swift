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
    
    var cellType: PersonalDinnerCellType?{
        didSet{
            if cellType == .CustomeMadeType {
                otherInfoLabel.hidden = false
            }else{
                otherInfoLabel.hidden = true
            }
        }
    }
    
    var customeMadeModel: Themedinner?{
        didSet{
            dinnerImage.sd_setImageWithURL(NSURL(string: (customeMadeModel?.themeImage!.componentsSeparatedByString(",")[0])!), placeholderImage: nil)
            titleLabel.text = customeMadeModel!.title!
            let timeRange = customeMadeModel!.startTime!.getDateFormate() + " - " + customeMadeModel!.endTime!.getDateFormate()
            otherInfoLabel.text = "\(customeMadeModel!.district!)\(timeRange)"
            priceLabel.text = "¥\(customeMadeModel!.minPrice) / \(customeMadeModel!.unit!)"
            scheduleButton.tag = (customeMadeModel?.themeId)!
        }
    }
    
    var goodsModel: ChefInfoGoods?{
        didSet{
            dinnerImage.sd_setImageWithURL(NSURL(string: (goodsModel?.propertiesImage!.componentsSeparatedByString(",")[0])!), placeholderImage: nil)
            titleLabel.text = goodsModel!.title!
            priceLabel.text = "\(goodsModel!.subtitle!)"
            scheduleButton.tag = (goodsModel?.goodsId)!
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
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Normal)
        btn.layer.borderColor = Constant.Common.OrangeColor.CGColor
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = 3
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
        selectionStyle = .None
        contentView.addSubview(dinnerImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(otherInfoLabel)
        containerView.addSubview(scheduleButton)
        contentView.addSubview(containerView)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        if !didUpdateConstraints {
            dinnerImage.autoSetDimensionsToSize(CGSize(width: 150.0.fitHeight(), height: 150.0.fitHeight()))
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
            scheduleButton.autoSetDimension(.Width, toSize: 100.0.fitWidth())
            
            if cellType == .CustomeMadeType {
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
