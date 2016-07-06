//
//  SocialView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/5.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class SocialView: UIView {

    private var didUpdateConstraints = false
    private var weChat: CustomButton!
    private var wechatTimeline: CustomButton!
    private var canCelButton: UIButton!
    private var line: UIView!
    private var backGroudView: UIView!
    private var containerView: UIView!
    
    private static let share: SocialView =  SocialView(frame: UIScreen.mainScreen().bounds)
    
    class func shareInstance() -> SocialView{
        return share
    }
    
    func showSocialView() {
        UIApplication.sharedApplication().windows.last?.addSubview(self)
        UIView.animateWithDuration(0.3) { 
            self.containerView.transform = CGAffineTransformMakeTranslation(0, -380.0.fitHeight())
        }
    }
    
    func dismissSocialView() {
        UIView.animateWithDuration(0.3, animations: { 
            self.containerView.transform = CGAffineTransformIdentity
            }) { (_) in
                    self.removeFromSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        backGroudView = UIView()
        backGroudView.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        backGroudView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "backGroudViewClick:")
        backGroudView.addGestureRecognizer(tap)
        addSubview(backGroudView)
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.redColor()
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
        dismissSocialView()
    }
    
    func cancel() {
        dismissSocialView()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            backGroudView.autoPinEdgesToSuperviewEdges()
            
            containerView.autoSetDimensionsToSize(CGSize(width: ScreenSize.SCREEN_WIDTH, height: 380.0.fitHeight()))
            containerView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: -380.0.fitHeight())
            containerView.autoPinEdgeToSuperviewEdge(.Left)
            
            weChat.autoPinEdgeToSuperviewEdge(.Left, withInset: 190.0.fitWidth())
            weChat.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            wechatTimeline.autoPinEdgeToSuperviewEdge(.Right, withInset: 190.0.fitWidth())
            wechatTimeline.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
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
