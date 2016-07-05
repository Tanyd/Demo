//
//  ChefInfoCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfoCell: UITableViewCell {

    private var didUpdateConstraints = false
   
    private lazy var titleLable: UILabel = {
        let title = UILabel.lableCutomer("主厨介绍", fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 16)
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var contentLable: UILabel = {
        let content = UILabel.lableCutomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 13)
        content.numberOfLines = 0
        content.textAlignment = .Center
        return content
    }()
    
    private lazy var nameLale: UILabel = {
        let name = UILabel.lableCutomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 13)
        return name
    }()
    
    private lazy var chefIcon: UIImageView = {
        let icon = UIImageView.newAutoLayoutView()
        return icon
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(nameLale)
        contentView.addSubview(chefIcon)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefDinner?) {
        if model != nil {
            nameLale.text = model?.data?.baseInfo?.shopName
            chefIcon.sd_setImageWithURL(NSURL(string: (model?.data?.baseInfo?.imageurl!.componentsSeparatedByString(",")[0])!), placeholderImage: UIImage(named: "headerview"), completed: { (image, error, cacheType, url) in
                self.chefIcon.image = UIImage.circleImageWithImage(image)
            })
            contentLable.text = model?.data?.baseInfo?.introduce
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
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
