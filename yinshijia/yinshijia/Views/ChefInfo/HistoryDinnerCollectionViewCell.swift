//
//  HistoryDinnerCollectionViewCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/7.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class HistoryDinnerCollectionViewCell: UICollectionViewCell {
    
    private var didUpdateConstraints = false
    var historyDinner: Historydinner?{
        didSet{
            dinnerImage.sd_setImageWithURL(NSURL(string: (historyDinner?.imageurl)!), placeholderImage: nil)
            titleLabel.text = historyDinner?.title
            timeLabel.text = historyDinner?.datetime
            priceLabel.text = String(historyDinner?.price)
        }
    }
    var historyCusDinner: Historycustommadedinner?{
        didSet{
            dinnerImage.sd_setImageWithURL(NSURL(string: (historyCusDinner?.imageurl)!), placeholderImage: nil)
            let str = "[定制]" + (historyCusDinner?.name)!
            let mutableStr = NSMutableAttributedString(string: str)
            mutableStr.addAttributes([NSForegroundColorAttributeName: Constant.Common.OrangeColor], range: NSRange(location: 0,length: 4))
            titleLabel.text = String(mutableStr)
            timeLabel.text = historyCusDinner?.dinnertime
            priceLabel.text = String(historyCusDinner?.price)
        }
    }

    private lazy var dinnerImage: UIImageView = {
        return UIImageView.newAutoLayoutView()
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: Constant.Common.OrangeColor, fontSize: 13)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dinnerImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(priceLabel)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            dinnerImage.autoSetDimensionsToSize(CGSize(width: 192.0.fitWidth(), height: 150.0.fitHeight()))
            dinnerImage.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            
            titleLabel.autoPinEdgeToSuperviewEdge(.Left)
            titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: dinnerImage, withOffset: 20.0.fitHeight())
            titleLabel.autoPinEdgeToSuperviewEdge(.Right)
            
            timeLabel.autoPinEdgeToSuperviewEdge(.Left)
            timeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 20.0.fitHeight())
            timeLabel.autoPinEdgeToSuperviewEdge(.Right)
            
            priceLabel.autoPinEdgeToSuperviewEdge(.Left)
            priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: timeLabel, withOffset: 20.0.fitHeight())
            priceLabel.autoPinEdgeToSuperviewEdge(.Right)
            priceLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 35.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
