//
//  ChefInfoIntroductionCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfoIntroductionCell: ChefInfoCell {

    private var didUpdateConstraints = false

    private lazy var attentionButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage(named: "tag_btn_bg"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tag_create_btn"), forState: .Selected)
        btn.setTitle("关注主厨人", forState: .Normal)
        btn.setTitle("已关注", forState: .Selected)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(chefIcon)
        contentView.addSubview(nameLale)
        contentView.addSubview(contentLable)
        contentView.addSubview(attentionButton)
        setNeedsUpdateConstraints()
    }
    
     func configureChefModel(model: ChefInfoBaseinfo?) {
        if model != nil {
            chefIcon.sd_setImageWithURL(NSURL(string: (model?.headImageurl!.componentsSeparatedByString(",")[0])!), placeholderImage: UIImage(named: "headerview"), completed: { (image, error, cacheType, url) in
                self.chefIcon.image = UIImage.circleImageWithImage(image)
            })
            nameLale.text = model?.name
            contentLable.text = model?.introduce
            (model?.custom_order_flag == "1")  ? (attentionButton.selected = true) : (attentionButton.selected = false)
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            chefIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 30.0.fitHeight())
            chefIcon.autoSetDimensionsToSize(CGSize(width: 150.0.fitHeight(), height: 150.0.fitHeight()))
            chefIcon.autoAlignAxisToSuperviewAxis(.Vertical)
            
            nameLale.autoPinEdge(.Top, toEdge: .Bottom, ofView: chefIcon, withOffset: 43.0.fitHeight())
            nameLale.autoAlignAxisToSuperviewAxis(.Vertical)

            attentionButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLale, withOffset: 37.0.fitHeight())
            attentionButton.autoAlignAxisToSuperviewAxis(.Vertical)
            
            contentLable.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            contentLable.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            contentLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: attentionButton, withOffset: 30.0.fitHeight())
            contentLable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 45.0.fitHeight())
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
