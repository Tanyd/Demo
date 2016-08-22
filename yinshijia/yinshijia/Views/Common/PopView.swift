//
//  PopView.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/12.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class PopView: UIView {

    private var didUpdateConstraints = false
    
    private var backGroudView: UIView = {
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = UIColor.blackColor()
        return view
    }()
    
    var contenView: UIView!
    var contenH:CGFloat = 0
    var bottomMargin: CGFloat = 0
    var isShow = false
    
    private static var instance: PopView = {
        let temp = PopView(frame: UIScreen.mainScreen().bounds)
        temp.hidden = true
        return temp
    }()
    
    class func shareView() ->PopView {
        return instance
    }
    
    func configureView(view: UIView,contenH: CGFloat,bottomMargin: CGFloat,containerView: UIView?) {
        self.contenH = contenH
        self.bottomMargin = bottomMargin
        self.contenView = view
        addSubview(contenView)
        if containerView == nil {
            UIApplication.sharedApplication().windows.last?.addSubview(self)
        }else{
            containerView?.addSubview(self)
        }
        setNeedsUpdateConstraints()
    }
    
    func configureView(view: UIView,contenH: CGFloat,bottomMargin: CGFloat,containerView: UIView, belowView: UIView) {
        self.contenH = contenH
        self.bottomMargin = bottomMargin
        self.contenView = view
        addSubview(contenView)
        containerView.insertSubview(self, belowSubview: belowView)
        setNeedsUpdateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopView.backGroudViewClick(_:)))
        backGroudView.addGestureRecognizer(tap)
        addSubview(backGroudView)
    }

    func backGroudViewClick(tap: UITapGestureRecognizer) {
        dismiss()
    }
    
    func show() {
        if isShow {return}
        hidden = false
        isShow = true
        UIView.animateWithDuration(0.3) {
            self.backGroudView.alpha = 0.4
            self.contenView.transform = CGAffineTransformTranslate(self.contenView.transform, 0, -self.contenH)
        }
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: {
            self.backGroudView.alpha = 0.0
            self.contenView.transform = CGAffineTransformIdentity
        }) { (_) in
            self.hidden = true
            self.isShow = false
        }
    }
    
    override func updateConstraints() {
        backGroudView.autoPinEdgesToSuperviewEdges()
        contenView.autoPinEdgeToSuperviewEdge(.Top, withInset: ScreenSize.SCREEN_HEIGHT - bottomMargin)
        contenView.autoPinEdgeToSuperviewEdge(.Left)
        contenView.autoPinEdgeToSuperviewEdge(.Right)
        contenView.autoSetDimension(.Height, toSize: contenH)
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
