//
//  ButtonChangeView.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

protocol BtnPageViewDelegate: NSObjectProtocol{
    func btnPageViewDidTouchButton(fromIndex: Int,toIndex: Int)
}

class BtnPageView: UIView {

    private var bottomLine: UIView!
    private var leftBtn: buttonNoHighlighted!
    private var midBtn: buttonNoHighlighted!
    private var rightBtn: buttonNoHighlighted!
    private var selectedBtn: buttonNoHighlighted!
    private var titles = [String]()
    weak var delegate: BtnPageViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    convenience init(frame: CGRect,buttonTitles: [String]) {
        self.init(frame: frame)
        self.titles = buttonTitles
    }
    
    private func setUI() {
        leftBtn = setupButton(titles[0], tag: 0)
        leftBtn.selected = true
        selectedBtn = leftBtn
        midBtn = setupButton(titles[1], tag: 1)
        rightBtn = setupButton(titles[2], tag: 2)
        setBottomLine()
    }
    
    private func setBottomLine() {
        bottomLine = UIView()
        bottomLine.backgroundColor = Constant.Common.OrangeColor
        addSubview(bottomLine)
    }
    
    private func setupButton(title: String,tag: Int) -> buttonNoHighlighted{
        let btn = buttonNoHighlighted(type: .Custom)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Selected)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.tag = tag
        btn.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        addSubview(btn)
        return btn
    }
    
    func titleButtonClick(sender: buttonNoHighlighted) {
        guard sender.tag != selectedBtn.tag else {return}
        selectedBtn.selected = false
        sender.selected = true
        UIView.animateWithDuration(0.35) {
            self.bottomLine.transform = CGAffineTransformTranslate(self.bottomLine.transform, sender.center.x - self.selectedBtn.center.x, 0)
        }
        
        if delegate != nil && (delegate?.respondsToSelector("btnPageViewDidTouchButton:toIndex:"))! {
            delegate?.btnPageViewDidTouchButton(selectedBtn.tag, toIndex: sender.tag)
        }
        selectedBtn = sender
    }
    
    func exchangeSelectedButton(fromIndex: Int, toIndex: Int){
        
        var btn: buttonNoHighlighted!
        switch toIndex {
        case 0:
            btn = leftBtn
        case 1:
            btn = midBtn
        case 2:
            btn = rightBtn
        default:
            break
        }
        
        guard btn.tag != selectedBtn.tag else {return}
        selectedBtn.selected = false
        btn.selected = true
        UIView.animateWithDuration(0.35) {
            self.bottomLine.transform = CGAffineTransformTranslate(self.bottomLine.transform, btn.center.x - self.selectedBtn.center.x, 0)
        }
        
        selectedBtn = btn
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnWidth = bounds.size.width / 3
        let lineWidth = btnWidth * 0.25
        leftBtn.frame = CGRectMake(btnWidth * CGFloat(leftBtn.tag), 0, btnWidth, height)
        midBtn.frame = CGRectMake(btnWidth * CGFloat(midBtn.tag), 0, btnWidth, height)
        rightBtn.frame = CGRectMake(btnWidth * CGFloat(rightBtn.tag), 0, btnWidth, height)
        bottomLine.bounds = CGRectMake(0, 0, lineWidth, 2)
        bottomLine.center = CGPoint(x: leftBtn.center.x, y: height - 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class buttonNoHighlighted: UIButton {
    override var highlighted: Bool{
        didSet{
            super.highlighted = false
        }
    }
}
