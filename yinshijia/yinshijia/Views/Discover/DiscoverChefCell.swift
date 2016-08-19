//
//  DiscoverChefCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/9.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DiscoverChefCell: UITableViewCell {

    private var didUpdateConstraints = false
    var chefModel: Chefs?{
        didSet{
            tag = (chefModel?.userId)!
            userIcon.sd_setImageWithURL(NSURL(string: (chefModel?.imageurl)!), placeholderImage: UIImage(named: "headerview"))
            name.text = chefModel?.name
            scheduleLove.text = "\(chefModel!.orderedCount)人预定 | \(chefModel!.likeCount)人关注"
            contentLabel.text = chefModel!.introduce!
            if chefModel?.favorite == true {
                scheduleButton.selected = true
            }else{
                scheduleButton.selected = false
            }
        }
    }
    private lazy var userIcon: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        img.aliCornerRadius = 92.0.fitHeight() * 0.5
        return img
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.blackColor(), fontSize: 12)
        return label
    }()
    
    private lazy var name: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 12)
        return lable
    }()
    
    private lazy var scheduleLove: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 12)
        return lable
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    private lazy var scheduleButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Selected)
        btn.layer.borderColor = UIColor.grayColor().CGColor
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = 3
        btn.action = {[weak self] in self?.schedule(btn)}
        btn.setTitle("加关注", forState: .Normal)
        btn.setTitle("已关注", forState: .Selected)
        return btn
    }()
    
    func schedule(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            sender.layer.borderColor = Constant.Common.OrangeColor.CGColor
        }else{
            sender.layer.borderColor = UIColor.grayColor().CGColor
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorFromHex(0xeaeaea)
        containerView.addSubview(userIcon)
        containerView.addSubview(name)
        containerView.addSubview(scheduleLove)
        containerView.addSubview(contentLabel)
        containerView.addSubview(scheduleButton)
        contentView.addSubview(containerView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            userIcon.autoSetDimensionsToSize(CGSize(width: 92.0.fitHeight(), height: 92.0.fitHeight()))
            userIcon.autoPinEdgeToSuperviewEdge(.Left, withInset: 18.0.fitWidth())
            userIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 22.0.fitHeight())
            
            scheduleButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 20.0.fitWidth())
            scheduleButton.autoPinEdge(.Top, toEdge: .Top, ofView: userIcon)
            scheduleButton.autoSetDimensionsToSize(CGSize(width: 107.0.fitWidth(), height: 46.0.fitHeight()))
            
            name.autoPinEdge(.Top, toEdge: .Top, ofView: userIcon)
            name.autoPinEdge(.Left, toEdge: .Right, ofView: userIcon, withOffset: 17.0.fitWidth())
            
            scheduleLove.autoPinEdge(.Left, toEdge: .Left, ofView: name)
            scheduleLove.autoPinEdge(.Top, toEdge: .Bottom, ofView: name, withOffset: 15.0.fitHeight())
            
            contentLabel.autoPinEdge(.Left, toEdge: .Left, ofView: userIcon)
            contentLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            contentLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 25.0.fitHeight())
            
            containerView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(20.0.fitHeight(), 20.0.fitWidth(), 0, 20.0.fitWidth()))
            didUpdateConstraints = true
        }
        super.updateConstraints()
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
