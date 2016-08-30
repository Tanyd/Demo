//
//  ScheduleNumberCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ScheduleNumberCell: UITableViewCell {

    private var didUpdateConstraints = false
    private var curretNumber = 1{
        didSet{
            if curretNumber >= 1 && curretNumber <= maxNumber {
                if curretNumber == 1 {
                    removeBtn.selected = false
                    addBtn.selected = true
                }else if curretNumber == maxNumber {
                    addBtn.selected = false
                    removeBtn.selected = true
                }else {
                    addBtn.selected = true
                    removeBtn.selected = true
                }
                numberLabel.text = String(curretNumber)
                NSNotificationCenter.defaultCenter().postNotificationName(Constant.NotificationName.MarketGoodsChooseNumber, object: nil, userInfo: [Constant.NotificationName.MarketGoodsChooseNumberKey:curretNumber])
            }else if curretNumber == 0 {
                curretNumber += 1
            }else if curretNumber == maxNumber + 1 {
                curretNumber -= 1
            }
        }
    }
    var maxNumber = 9
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.labelCustomer("选择数量", fontType: nil, color: UIColor.lightGrayColor(), fontSize: 15)
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel.labelCustomer("1", fontType: nil, color: UIColor.blackColor(), fontSize: 15)
        label.textAlignment = .Center
        label.layer.borderColor = UIColor.lightGrayColor().CGColor
        label.layer.borderWidth = 0.7
        return label
    }()
    
    private lazy var removeBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage(named: "remove_person_gray"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "remove_person_black"), forState: .Selected)
        btn.action = {[weak self] in self?.remove(btn)}
        return btn
    }()
    
    private lazy var addBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setBackgroundImage(UIImage(named: "add_person_black"), forState: .Selected)
        btn.setBackgroundImage(UIImage(named: "add_person_gray"), forState: .Normal)
        btn.selected = true
        btn.action = {[weak self] in self?.add(btn)}
        return btn
    }()
    
    func remove(sender: UIButton) {
        curretNumber -= 1
    }
    
    func add(sender: UIButton) {
        curretNumber += 1
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addBtn)
        contentView.addSubview(removeBtn)
        contentView.addSubview(numberLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            titleLabel.autoSetDimension(.Height, toSize: 44)
            
            addBtn.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            addBtn.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            numberLabel.autoSetDimension(.Height, toSize: 50.0.fitHeight())
            numberLabel.autoSetDimension(.Width, toSize: 80.0.fitWidth())
            numberLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
            numberLabel.autoPinEdge(.Right, toEdge: .Left, ofView: addBtn, withOffset: -15.0.fitWidth())
            
            removeBtn.autoPinEdge(.Right, toEdge: .Left, ofView: numberLabel, withOffset: -15.0.fitWidth())
            removeBtn.autoAlignAxisToSuperviewAxis(.Horizontal)
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
