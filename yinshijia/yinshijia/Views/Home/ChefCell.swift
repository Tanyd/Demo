//
//  ChefCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/12.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
enum ChefCellType {
    case chefType
    case goodsType
}
class ChefCell: UICollectionViewCell {
    
    private var didUpdateConstraints = false
    
    var type: ChefCellType?{
        didSet{
            if type == .chefType{
                schedule.hidden = false
                love.hidden = false
                introduction.textColor = UIColor.colorFromHex(0x868686)
                name.numberOfLines = 1
            }else{
                schedule.hidden = true
                love.hidden = true
                introduction.textColor = Constant.Common.OrangeColor
                name.numberOfLines = 2
            }
        }
    }
    
    var chefModel: Cheflist?{
        didSet{
            icon.sd_setImageWithURL(NSURL(string: chefModel!.imageurl!), placeholderImage: UIImage(named: "wutu"))
            name.text = chefModel!.name
            schedule.text = String(chefModel!.orderedCount) + " | "
            love.text = String(chefModel!.likeCount)
            introduction.text = chefModel!.introduce!
            tag = chefModel!.userId
        }
    }
    
    var goodsModel: GoodsData?{
        didSet{
            name.text = goodsModel!.title
            introduction.text = goodsModel!.subtitle
            tag = goodsModel!.goodsId
        }
    }
    
    lazy var icon: UIImageView = {
       let img = UIImageView.newAutoLayoutView()
        return img
    }()
    
    private lazy var name: UILabel = {
       let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 14)
        return lable
    }()
    
    private lazy var schedule: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.colorFromHex(0x929292), fontSize: 11)
        return lable
    }()

    private lazy var love: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.colorFromHex(0x929292), fontSize: 11)
        return lable
    }()
    
    private lazy var introduction: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.colorFromHex(0x868686), fontSize: 12)
        lable.numberOfLines = 0
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        contentView.backgroundColor = UIColor.colorFromHex(0xffffff)
        contentView.addSubview(icon)
        contentView.addSubview(name)
        contentView.addSubview(schedule)
        contentView.addSubview(love)
        contentView.addSubview(introduction)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            icon.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            icon.autoSetDimension(.Height, toSize: 350.0.fitHeight())
            
            name.autoPinEdgeToSuperviewEdge(.Left, withInset: 15.0.fitWidth())
            introduction.autoPinEdge(.Left, toEdge: .Left, ofView: name)

            if type == .chefType {
                
                name.autoPinEdge(.Top, toEdge: .Bottom, ofView: icon, withOffset: 15.0.fitHeight())
                
                schedule.autoPinEdge(.Left, toEdge: .Left, ofView: name)
                schedule.autoPinEdge(.Top, toEdge: .Bottom, ofView: name, withOffset: 15.0.fitHeight())
                
                love.autoPinEdge(.Left, toEdge: .Right, ofView: schedule)
                love.autoPinEdge(.Top, toEdge: .Bottom, ofView: name, withOffset: 15.0.fitHeight())
                
                introduction.autoPinEdge(.Top, toEdge: .Bottom, ofView: icon, withOffset: 95.0.fitHeight())
                introduction.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 25.0.fitHeight())
                introduction.autoPinEdgeToSuperviewEdge(.Right,withInset: 30.0.fitWidth())
        
            }else{
                name.autoPinEdge(.Top, toEdge: .Bottom, ofView: icon)
                name.autoPinEdgeToSuperviewEdge(.Right, withInset: 15.0.fitWidth())
                name.autoSetDimension(.Height, toSize: 80.0.fitHeight())
                
                introduction.autoPinEdge(.Top, toEdge: .Bottom, ofView: name)
                introduction.autoPinEdgeToSuperviewEdge(.Bottom)
                introduction.autoPinEdgeToSuperviewEdge(.Right, withInset: 15.0.fitWidth())
            }
            
            

            self.didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
