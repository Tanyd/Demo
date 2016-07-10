//
//  ChefInfoCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
enum ChefInfoCellType: Int {
    case ChefDinner
    case ChefInfo
    case ChefGodds
}

class ChefInfoCell: UITableViewCell {

    private var didUpdateConstraints = false
    var type: ChefInfoCellType?{
        didSet{
            switch type! {
            case .ChefDinner:
                titleLable.hidden = false
                attentionButton.hidden = true
            case .ChefInfo:
                titleLable.hidden = true
                attentionButton.hidden = false
            default:
                titleLable.hidden = true
                attentionButton.hidden = true
            }
        }
    }
    private lazy var titleLable: UILabel = {
        let title = UILabel.labelCustomer("主厨介绍", fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 16)
        title.numberOfLines = 0
        return title
    }()
    
    lazy var contentLable: UILabel = {
        let content = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 13)
        content.numberOfLines = 0
        content.textAlignment = .Center
        return content
    }()
    
    lazy var nameLale: UILabel = {
        let name = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 13)
        return name
    }()
    
    lazy var chefIcon: UIImageView = {
        let icon = UIImageView.newAutoLayoutView()
        icon.layer.cornerRadius = 130.0.fitHeight() * 0.5
        icon.clipsToBounds = true
        return icon
    }()
    
    private lazy var attentionButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Selected)
        btn.setBackgroundImage(UIImage(named: "create_btn"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tag_create_btn"), forState: .Selected)
        btn.setTitle("关注主厨人", forState: .Normal)
        btn.setTitle("已关注", forState: .Selected)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(nameLale)
        contentView.addSubview(chefIcon)
        contentView.addSubview(attentionButton)
        setNeedsUpdateConstraints()
    }
    
    func configureChefDinnerModel(model: ChefDinner?) {
        if model != nil {
            nameLale.text = model?.data?.baseInfo?.shopName
            chefIcon.sd_setImageWithURL(NSURL(string: (model?.data?.baseInfo?.imageurl!.componentsSeparatedByString(",")[0])!), placeholderImage: UIImage(named: "headerview"))
            contentLable.text = model?.data?.baseInfo?.introduce
        }
    }
    
    func configureChefModel(model: ChefInfoBaseinfo?) {
        if model != nil {
            chefIcon.sd_setImageWithURL(NSURL(string: (model?.headImageurl!.componentsSeparatedByString(",")[0])!), placeholderImage: UIImage(named: "headerview"))
            nameLale.text = model?.name
            contentLable.text = model?.introduce
            (model?.custom_order_flag == "1")  ? (attentionButton.selected = true) : (attentionButton.selected = false)
        }
    }
    
    func configureGoodsModel(model: MarketGoods?) {
        if model != nil {
            chefIcon.sd_setImageWithURL(NSURL(string: (model?.data!.shop_headImage!.componentsSeparatedByString(",")[0])!), placeholderImage: UIImage(named: "headerview"))
            nameLale.text = model?.data?.shop_nickName
            contentLable.text = model?.data?.shop_introduce
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            switch type! {
            case .ChefDinner:
                titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
                titleLable.autoAlignAxisToSuperviewAxis(.Vertical)
                
                chefIcon.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 60.0.fitHeight())
                chefIcon.autoSetDimensionsToSize(CGSize(width: 130.0.fitHeight(), height: 130.0.fitHeight()))
                chefIcon.autoAlignAxisToSuperviewAxis(.Vertical)
                
                nameLale.autoPinEdge(.Top, toEdge: .Bottom, ofView: chefIcon, withOffset: 30.0.fitHeight())
                nameLale.autoAlignAxisToSuperviewAxis(.Vertical)
                
                contentLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
                contentLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
                contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLale, withOffset: 30.0.fitHeight())
                contentLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 45.0.fitHeight())
                

            case .ChefInfo:
                chefIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 30.0.fitHeight())
                chefIcon.autoSetDimensionsToSize(CGSize(width: 130.0.fitHeight(), height: 130.0.fitHeight()))
                chefIcon.autoAlignAxisToSuperviewAxis(.Vertical)
                
                nameLale.autoPinEdge(.Top, toEdge: .Bottom, ofView: chefIcon, withOffset: 43.0.fitHeight())
                nameLale.autoAlignAxisToSuperviewAxis(.Vertical)
                
                attentionButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLale, withOffset: 37.0.fitHeight())
                attentionButton.autoSetDimensionsToSize(CGSize(width: 160.0.fitWidth(), height: 60.0.fitHeight()))
                attentionButton.autoAlignAxisToSuperviewAxis(.Vertical)
                
                contentLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
                contentLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
                contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: attentionButton, withOffset: 30.0.fitHeight())
                contentLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 45.0.fitHeight())
                
                
            default:
                chefIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 30.0.fitHeight())
                chefIcon.autoSetDimensionsToSize(CGSize(width: 130.0.fitHeight(), height: 130.0.fitHeight()))
                chefIcon.autoAlignAxisToSuperviewAxis(.Vertical)
                
                nameLale.autoPinEdge(.Top, toEdge: .Bottom, ofView: chefIcon, withOffset: 43.0.fitHeight())
                nameLale.autoAlignAxisToSuperviewAxis(.Vertical)
                
                contentLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
                contentLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
                contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLale, withOffset: 30.0.fitHeight())
                contentLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 45.0.fitHeight())

            }
            
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
    
    deinit{
        print("ChefInfoCell释放")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
