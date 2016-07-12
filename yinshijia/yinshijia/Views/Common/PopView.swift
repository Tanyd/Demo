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
        view.alpha = 0.0
        return view
    }()
    
    var contenView: UIView!
    var contenH:CGFloat = 0
    var bottomMargin: CGFloat = 0
    var isShow = false
    
    private static var instance: PopView = {
        return PopView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hidden = true
        setUI()
    }
    
    class func shareInstance() -> PopView{
        return instance
    }

    private func setUI(){
        let tap = UITapGestureRecognizer(target: self, action: "backGroudViewClick:")
        backGroudView.addGestureRecognizer(tap)
        addSubview(backGroudView)
        addSubview(contenView)
        setNeedsUpdateConstraints()
    }
    
    func backGroudViewClick(tap: UITapGestureRecognizer) {
        dismiss()
    }
    
    func show() {
        hidden = false
        isShow = true
        UIView.animateWithDuration(0.3) {
            self.backGroudView.alpha = 0.4
            self.contenView.transform = CGAffineTransformMakeTranslation(0, -self.contenH)
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
        if !didUpdateConstraints{
            backGroudView.autoPinEdgesToSuperviewEdges()
            contenView.autoPinEdgeToSuperviewEdge(.Top, withInset: ScreenSize.SCREEN_HEIGHT - bottomMargin)
            contenView.autoPinEdgeToSuperviewEdge(.Left)
            contenView.autoPinEdgeToSuperviewEdge(.Right)
            contenView.autoSetDimension(.Height, toSize: contenH)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
