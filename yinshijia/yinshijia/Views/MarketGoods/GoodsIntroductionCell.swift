//
//  MarketGoodsIntroductionCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class GoodsIntroductionCell: UITableViewCell {

    private var didUpdateConstraints = false

    var model: MarketGoods?{
        didSet{
            titleLable.text = model?.data!.title
            let mutableStr = NSMutableAttributedString(string: (model?.data!.subtitle)!)
            mutableStr.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], range: NSRange(location:  (model?.data?.subtitle?.length())! - 2,length: 2))
            priceLable.attributedText = mutableStr
            contenLable.text = model?.data!.desp
        }
    }
    
    private lazy var titleLable: UILabel = {
        let title = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 17)
        title.textAlignment = .Left
        return title
    }()
    
    private lazy var priceLable: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: nil, color: Constant.Common.OrangeColor, fontSize: 16)
        return lable
    }()
    
    private lazy var contenLable: UILabel = {
        let title = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.grayColor(), fontSize: 12)
        title.textAlignment = .Left
        title.numberOfLines = 0
        return title
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(priceLable)
        contentView.addSubview(contenLable)
        setNeedsUpdateConstraints()
    }
        
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            priceLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 30.0.fitHeight())
            priceLable.autoPinEdge(.Left, toEdge: .Left, ofView: titleLable)
            
            contenLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            contenLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            contenLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: priceLable, withOffset: 45.0.fitHeight())
            contenLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
