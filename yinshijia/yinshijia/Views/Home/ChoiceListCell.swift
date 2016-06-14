//
//  ChefListCell.swift
//  yinshijia
//
//  Created by Developer on 16/6/14.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChoiceListCell: ChoiceCell {

    var choiceListModel: Item?{
        didSet{
            titleLable.text = choiceListModel!.dinner_title!
            let timeRange = getDateFormate(choiceListModel!.dinner_datetime!) + " - " + getDateFormate(choiceListModel!.dinner_endOrderTime!)
            time.setTitle("  " + timeRange, forState: .Normal)
            customMade.setTitle(choiceListModel!.dinner_district!, forState: .Normal)
            priceLable.text = "¥ " + String(choiceListModel!.dinner_price) + " / " + choiceListModel!.unit!
            tag = (choiceListModel?.dinner_id)!
        }
    }
  
    private lazy var priceLable: UILabel = {
        let lable = UILabel.lableCutomer(nil, fontType: nil, color: Constant.Common.OrangeColor, fontSize: 13)
        return lable
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customMade.setTitleColor(UIColor.grayColor(), forState: .Normal)
        customMade.layer.borderColor = UIColor.grayColor().CGColor
        priceView.setBackgroundImage(UIImage(named: "cell_custom_theme"), forState: .Normal)
        priceView.setTitle("定制", forState: .Normal)
        contentView.addSubview(goodsImg)
        goodsImg.addSubview(priceView)
        contentView.addSubview(customMade)
        contentView.addSubview(titleLable)
        contentView.addSubview(time)
        contentView.addSubview(priceLable)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        if !didUpdateConstraints {
            goodsImg.autoPinEdgeToSuperviewEdge(.Left)
            goodsImg.autoPinEdgeToSuperviewEdge(.Right)
            goodsImg.autoPinEdgeToSuperviewEdge(.Top, withInset: 25.0.fitHeight())
            goodsImg.autoSetDimension(.Height, toSize: 450.0.fitHeight())
            
            priceView.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            priceView.autoPinEdgeToSuperviewEdge(.Left)
            
            titleLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 20.0.fitWidth())
            titleLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: goodsImg, withOffset: 20.0.fitHeight())
            titleLable.autoSetDimension(.Height, toSize: 55.0.fitHeight())
            
            customMade.autoPinEdgeToSuperviewEdge(.Right, withInset: 20.0.fitWidth())
            customMade.autoPinEdge(.Top, toEdge: .Bottom, ofView: goodsImg, withOffset: 30.0.fitHeight())
            customMade.autoSetDimension(.Width, toSize: 75.0.fitWidth())
            customMade.autoSetDimension(.Height, toSize: 40.0.fitHeight())
            
            time.autoPinEdge(.Left, toEdge: .Left, ofView: titleLable)
            time.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable)
            time.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10.0.fitHeight())
            
            priceLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: customMade)
            priceLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 20.0.fitWidth())
            priceLable.autoPinEdgeToSuperviewEdge(.Bottom)
            
            didUpdateConstraints = true
        }
            
          super.updateConstraints()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
