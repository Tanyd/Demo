//
//  ChoiceCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
enum ChoiceCellType {
    case choice
    case choiceList
}
class ChoiceCell: UITableViewCell {
    
    var didUpdateConstraints = false
    
    var dinnerChefClick: ((chefID: Int) -> Void)?
    
    var choiceModel: Dinnerlist?{
        didSet{
            let chefImg = choiceModel!.themeDinnerChefImageurl == nil ? choiceModel?.chefImageurl : choiceModel!.themeDinnerChefImageurl
            userIcon.sd_setImageWithURL(NSURL(string: chefImg!), placeholderImage: UIImage(named: "headerview"))
            let img = choiceModel!.themeDinnerImageurl == nil ? choiceModel!.chefImageurl : choiceModel!.themeDinnerImageurl
            let goodsImgArray = img!.componentsSeparatedByString(",")
            goodsImg.sd_setImageWithURL(NSURL(string: goodsImgArray[0]), placeholderImage: UIImage(named: "wutu"))
            
            let priceStr = choiceModel!.themeDinnerMinPrice == 0 ? String(choiceModel!.price!) : String(choiceModel!.themeDinnerMinPrice)
            let price = "¥" + priceStr + "/" + (choiceModel!.themeDinnerUnit == nil ? "位" : choiceModel!.themeDinnerUnit!)
            priceView.setTitle(price, forState: .Normal)
            let title = choiceModel!.themeDinnerTitle == nil ? choiceModel!.title : choiceModel!.themeDinnerTitle
            titleLable.text = title
            let distrc = choiceModel!.themeDinnerDistrict == nil ? choiceModel!.district : choiceModel!.themeDinnerDistrict
            location.setTitle("  " + distrc!, forState: .Normal)
            let startTime = choiceModel!.themeDinnerStartTime == nil ? choiceModel?.datetime : choiceModel!.themeDinnerStartTime
            let endTime = choiceModel!.themeDinnerEndTime == nil ? choiceModel?.endOrderTime : choiceModel!.themeDinnerEndTime
            let timeRange = startTime!.getDateFormate() + " - " + endTime!.getDateFormate()
            time.setTitle("  " + timeRange, forState: .Normal)
            userIcon.tag = (choiceModel?.themeDinnerChefId)!
            tag = (choiceModel?.themeDinnerId)!
        }
    }

    
    lazy var goodsImg: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        return img
    }()
    
    lazy var priceView: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.userInteractionEnabled = false
        return btn
    }()
    
  
    
    lazy var customMade: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitle("定制", forState: .Normal)
        btn.layer.cornerRadius = 2
        btn.layer.borderWidth = 1
        btn.titleLabel?.font = UIFont.systemFontOfSize(11)
        btn.userInteractionEnabled = false
        return btn
    }()

    lazy var userIcon: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        img.aliCornerRadius = 114.0.fitWidth() * 0.5
        img.layer.borderColor = UIColor.whiteColor().CGColor
        img.layer.borderWidth = 2.0
        img.layer.cornerRadius = 114.0.fitWidth() * 0.5
        img.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "userIconDidClick:")
        img.addGestureRecognizer(tap)
        return img
    }()
    
    func userIconDidClick(sender: UITapGestureRecognizer) {
        if dinnerChefClick != nil {
            dinnerChefClick!(chefID: sender.view!.tag)
        }
    }
    
    lazy var titleLable: UILabel = {
        let lable = UILabel.labelCustomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.colorFromHex(0x222222), fontSize: 16)
        return lable
    }()
    
    lazy var location: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.setImage(UIImage(named: "cell_location"), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    lazy var time: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.setImage(UIImage(named: "cell_clock"), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.userInteractionEnabled = false
        return btn
    }()
 
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customMade.setTitleColor(Constant.Common.OrangeColor, forState: .Normal)
        customMade.layer.borderColor = Constant.Common.OrangeColor.CGColor
        priceView.setBackgroundImage(UIImage(named: "hotDinner_toast"), forState: .Normal)
        contentView.addSubview(goodsImg)
        goodsImg.addSubview(priceView)
        contentView.addSubview(customMade)
        contentView.addSubview(titleLable)
        contentView.addSubview(location)
        contentView.addSubview(time)
        contentView.addSubview(userIcon)
        setNeedsUpdateConstraints()
    }
    

    override func updateConstraints() {

        if !didUpdateConstraints {
            goodsImg.autoPinEdgeToSuperviewEdge(.Left)
            goodsImg.autoPinEdgeToSuperviewEdge(.Right)
            goodsImg.autoPinEdgeToSuperviewEdge(.Top, withInset: 15.0.fitHeight())
            goodsImg.autoSetDimension(.Height, toSize: 500.0.fitHeight())
            
            priceView.autoPinEdgeToSuperviewEdge(.Left)
            priceView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 40.0.fitHeight())
            
            userIcon.autoPinEdgeToSuperviewEdge(.Right, withInset: 20.0.fitWidth())
            userIcon.autoSetDimensionsToSize(CGSize(width: 114.0.fitWidth(), height: 114.0.fitWidth()))
            userIcon.autoPinEdge(.Top, toEdge: .Top, ofView: goodsImg, withOffset: 500.0.fitHeight() - 114.0.fitWidth() * 0.5)
            
            customMade.autoPinEdge(.Top, toEdge: .Bottom, ofView: goodsImg, withOffset: 30.0.fitHeight())
            customMade.autoSetDimension(.Width, toSize: 75.0.fitWidth())
            customMade.autoSetDimension(.Height, toSize: 40.0.fitHeight())
            customMade.autoPinEdgeToSuperviewEdge(.Left, withInset: 20.0.fitWidth())

            titleLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: goodsImg, withOffset: 30.0.fitHeight())
            titleLable.autoPinEdge(.Left, toEdge: .Right, ofView: customMade, withOffset: 20.0.fitWidth())

            location.autoPinEdge(.Left, toEdge: .Left, ofView: customMade)
            location.autoPinEdge(.Top, toEdge: .Bottom, ofView: customMade ,withOffset: 30.0.fitHeight())
            location.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())

            time.autoPinEdge(.Left, toEdge: .Right, ofView: location, withOffset: 20.0.fitWidth())
            time.autoPinEdge(.Top, toEdge: .Top, ofView: location)
            time.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: location)

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
