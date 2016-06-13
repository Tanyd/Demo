//
//  ChoiceCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChoiceCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    
    var model: Dinnerlist?{
        didSet{
//            let goodsImgArray = model!.themeDinnerImageurl!.componentsSeparatedByString(",")
//            goodsImg.sd_setImageWithURL(NSURL(string: goodsImgArray[0]), placeholderImage: UIImage(named: "wutu"))
//            userIcon.sd_setImageWithURL(NSURL(string: model!.themeDinnerChefImageurl!), placeholderImage: UIImage(named: "headerview"))
            let price = "¥" + String(model!.themeDinnerMinPrice) + "/" + model!.themeDinnerUnit!
            priceView.setTitle(price, forState: .Normal)
            titleLable.text = model!.themeDinnerTitle!
            location.setTitle("  " + model!.themeDinnerDistrict!, forState: .Normal)
            let timeRange = getDateFormate(model!.themeDinnerStartTime!) + " - " + getDateFormate(model!.themeDinnerEndTime!)
            time.setTitle("  " + timeRange, forState: .Normal)
            tag = (model?.chefId)!
        }
    }
    
    private func getDateFormate(date: String) -> String{
        let t = "yyyy-MM-dd HH:mm:ss"
        let formate = NSDateFormatter()
        formate.dateFormat = t
        let current = formate.dateFromString(date)
        let t2 = "MM月dd日"
        let formate2 = NSDateFormatter()
        formate2.dateFormat = t2
        return formate2.stringFromDate(current!)
    }
    
    
    var goodsImg: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        return img
    }()
    
    private var priceView: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.setBackgroundImage(UIImage(named: "hotDinner_toast"), forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    private var customMade: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitle("定制", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(11)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = Constant.Common.OrangeColor.CGColor
        btn.layer.cornerRadius = 2
        btn.userInteractionEnabled = false
        return btn
    }()

    var userIcon: UIImageView = {
        let img = UIImageView.newAutoLayoutView()
        img.layer.borderWidth = 2.0
        img.layer.borderColor = UIColor.whiteColor().CGColor
        img.layer.cornerRadius = 57.0.fitWidth()
        img.layer.masksToBounds = true
        return img
    }()
    
    private var titleLable: UILabel = {
        let lable = UILabel.lableCutomer(nil, fontType: Constant.Common.BoldFont, color: UIColor.colorFromHex(0x222222), fontSize: 16)
        return lable
    }()
    
    private var location: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.setImage(UIImage(named: "cell_location"), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    private var time: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.setImage(UIImage(named: "cell_clock"), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    class func choiceCellWithTableView(tableView: UITableView) -> ChoiceCell {
        let identifier = String(ChoiceCell)
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ChoiceCell
        if cell == nil {
            cell = ChoiceCell(style: .Default, reuseIdentifier: identifier) 
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            
            customMade.autoPinEdgeToSuperviewEdge(.Left, withInset: 20.0.fitWidth())
            customMade.autoPinEdge(.Top, toEdge: .Bottom, ofView: goodsImg, withOffset: 30.0.fitHeight())
            customMade.autoSetDimension(.Width, toSize: 75.0.fitWidth())
            customMade.autoSetDimension(.Height, toSize: 40.0.fitHeight())
            
            titleLable.autoPinEdge(.Left, toEdge: .Right, ofView: customMade, withOffset: 20.0.fitWidth())
            titleLable.autoPinEdge(.Top, toEdge: .Bottom, ofView: goodsImg, withOffset: 30.0.fitHeight())
            
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
