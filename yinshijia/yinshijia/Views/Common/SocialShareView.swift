//
//  SocialShareView.swift
//  yinshijia
//
//  Created by Developer on 16/7/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class SocialShareView: UIView {

    private var didUpdateConstraints = false
    private var weChat: CustomButton!
    private var wechatTimeline: CustomButton!
    private var canCelButton: UIButton!
    private var line: UIView!
    private var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        containerView = UIView()
        containerView.backgroundColor = UIColor.whiteColor()
        addSubview(containerView)
        weChat = setSocialButton("微信", image: "wechat", tag: 0)
        containerView.addSubview(weChat)
        wechatTimeline = setSocialButton("朋友圈", image: "wechat_session", tag: 1)
        containerView.addSubview(wechatTimeline)
        canCelButton = UIButton(type: .Custom)
        canCelButton.setTitle("取消", forState: .Normal)
        canCelButton.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        canCelButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        canCelButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        containerView.addSubview(canCelButton)
        line = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        containerView.addSubview(line)
        setNeedsUpdateConstraints()
    }
    
    private func setSocialButton(title: String, image: String, tag: Int) -> CustomButton {
        let btn = CustomButton(type: .Custom)
        btn.type = .ImgTop
        btn.margin = 10.0.fitHeight()
        btn.setImage(UIImage(named: image), forState: .Normal)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(18)
        btn.addTarget(self, action: "shareClick:", forControlEvents: .TouchUpInside)
        btn.tag = tag
        return btn
    }
    
    func shareClick(sender: CustomButton) {
        switch sender.tag {
        case 0:
            print("WeChat")
        default:
            print("WechatTimeline")
        }
    }
    
    func backGroudViewClick(tap: UITapGestureRecognizer) {
        PopView.shareView().dismiss()
    }
    
    func cancel() {
        PopView.shareView().dismiss()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            containerView.autoPinEdgesToSuperviewEdges()
//            containerView.autoSetDimensionsToSize(CGSize(width: ScreenSize.SCREEN_WIDTH, height: 380.0.fitHeight()))
//            containerView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: -380.0.fitHeight())
//            containerView.autoPinEdgeToSuperviewEdge(.Left)
            
            weChat.autoPinEdgeToSuperviewEdge(.Left, withInset: 150.0.fitWidth())
            weChat.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            wechatTimeline.autoPinEdgeToSuperviewEdge(.Right, withInset: 150.0.fitWidth())
            wechatTimeline.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            wechatTimeline.autoMatchDimension(.Width, toDimension: .Width, ofView: weChat)
            
            canCelButton.autoPinEdgeToSuperviewEdge(.Bottom)
            canCelButton.autoPinEdgeToSuperviewEdge(.Left)
            canCelButton.autoPinEdgeToSuperviewEdge(.Right)
            canCelButton.autoSetDimension(.Height, toSize: 110.0.fitHeight())
            
            line.autoPinEdgeToSuperviewEdge(.Right)
            line.autoPinEdgeToSuperviewEdge(.Left)
            line.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 110.0.fitHeight() + 1)
            line.autoSetDimension(.Height, toSize: 1)
            
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

