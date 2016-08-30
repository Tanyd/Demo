//
//  ChefSectionView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/12.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
//MARK: hot new 切换BUG
class ChefSectionView: UICollectionReusableView {
 
    private var didUpdateConstraints = false
    private var titleLable: UILabel!
    private var hotButton: UIButton!
    private var newButton: UIButton!
    private var boldLine: UIView!
    private var line: UIView!
    private var selectedBtn: UIButton?
    var chefBtnClick: ((chefType: ChefSectionViewType)-> Void)?

    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        backgroundColor = UIColor.colorFromHex(0xffffff)
        setUI()
        setNeedsUpdateConstraints()
    }
    
    private func setUI() {
        titleLable = UILabel()
        titleLable.text = "隐食家"
        titleLable.textColor = Constant.Common.OrangeColor
        titleLable.font = UIFont(name: Constant.Common.BoldFont, size: 14)
        addSubview(titleLable)
        
        boldLine = UIView()
        boldLine.backgroundColor = Constant.Common.OrangeColor
        addSubview(boldLine)
        
        hotButton = setBtn("最热", action: #selector(ChefSectionView.buttonClick(_:)))
        hotButton.selected = true
        selectedBtn = hotButton
        hotButton.tag = ChefSectionViewType.chefHot.rawValue
        addSubview(hotButton)
        
        newButton = setBtn("最新", action: #selector(ChefSectionView.buttonClick(_:)))
        newButton.tag = ChefSectionViewType.chefNew.rawValue
        addSubview(newButton)
        
        line = UIView()
        line.backgroundColor = UIColor.grayColor()
        addSubview(line)
    }
    
    private func setBtn(title: String,action: Selector) -> UIButton {
        let btn = UIButton(type: .Custom)
        btn.titleLabel?.font = UIFont(name: Constant.Common.BoldFont, size: 13)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Selected)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.setTitle(title, forState: .Normal)
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        return btn
    }
    
    func buttonClick(sender: UIButton) {
        if sender == selectedBtn {return}
        if chefBtnClick != nil {
            selectedBtn!.selected = false
            sender.selected = true
            selectedBtn = sender
            chefBtnClick!(chefType: ChefSectionViewType(rawValue: sender.tag)!)
        }
    }
    
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            boldLine.autoPinEdgeToSuperviewEdge(.Left, withInset: 20.0.fitWidth())
            boldLine.autoSetDimensionsToSize(CGSize(width: 4, height: 40.0.fitHeight()))
            boldLine.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            titleLable.autoPinEdge(.Left, toEdge: .Right, ofView: boldLine, withOffset: 15.0.fitWidth())
            titleLable.autoPinEdge(.Top, toEdge: .Top, ofView: boldLine)
            titleLable.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: boldLine)
            
            newButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 20.0.fitWidth())
            newButton.autoPinEdge(.Top, toEdge: .Top, ofView: boldLine)
            newButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: boldLine)
            
            line.autoPinEdge(.Right, toEdge: .Left, ofView: newButton, withOffset: -15.0.fitWidth())
            line.autoPinEdge(.Top, toEdge: .Top, ofView: boldLine)
            line.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: boldLine)
            line.autoSetDimension(.Width, toSize: 2)
            
            hotButton.autoPinEdge(.Right, toEdge: .Left, ofView: line, withOffset: -15.0.fitWidth())
            hotButton.autoPinEdge(.Top, toEdge: .Top, ofView: boldLine)
            hotButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: boldLine)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    

    
    
}
