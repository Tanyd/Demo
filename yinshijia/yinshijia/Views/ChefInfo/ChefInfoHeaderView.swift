//
//  ChefInfoHeaderView.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfoHeaderView: UIView {

    private var didUpdateConstraints = false
    private var backGroudImg: UIImageView!
    private var titlesContainer: UIView!
    private var scheduleLable: UILabel!
    private var attentionLable: UILabel!
    private var commentLable: UILabel!
    private var lineLeft: UIView!
    private var lineRight: UIView!
    private var commentAction: (()->())?
    
    convenience init(frame: CGRect, commentAction: ()->()) {
        self.init(frame: frame)
        self.commentAction = commentAction
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        backGroudImg = UIImageView.newAutoLayoutView()
        backGroudImg.backgroundColor = UIColor.RandomColr()
        addSubview(backGroudImg)
        
        titlesContainer = UIView.newAutoLayoutView()
        titlesContainer.backgroundColor = UIColor.RandomColr()
        addSubview(titlesContainer)
        
        scheduleLable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.whiteColor(), fontSize: 13)
        scheduleLable.numberOfLines = 2
        scheduleLable.textAlignment = .Center
        titlesContainer.addSubview(scheduleLable)
        
        attentionLable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.whiteColor(), fontSize: 13)
        attentionLable.numberOfLines = 2
        attentionLable.textAlignment = .Center
        titlesContainer.addSubview(attentionLable)
        
        commentLable = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.whiteColor(), fontSize: 13)
        commentLable.numberOfLines = 2
        commentLable.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "commentClick:")
        commentLable.addGestureRecognizer(tap)
        commentLable.textAlignment = .Center
        titlesContainer.addSubview(commentLable)
        
        lineLeft = UIView.newAutoLayoutView()
        lineLeft.backgroundColor = UIColor.whiteColor()
        titlesContainer.addSubview(lineLeft)
        
        lineRight = UIView.newAutoLayoutView()
        lineRight.backgroundColor = UIColor.whiteColor()
        titlesContainer.addSubview(lineRight)
        setNeedsUpdateConstraints()
    }
    
    func commentClick(tap: UITapGestureRecognizer) {
        print("commentClick")
        if commentAction != nil {
            commentAction!()
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            backGroudImg.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            backGroudImg.autoSetDimension(.Height, toSize: 425.0.fitHeight())
            
            titlesContainer.autoPinEdge(.Top, toEdge: .Bottom, ofView: backGroudImg)
            titlesContainer.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
            
            let lableWidth = ScreenSize.SCREEN_WIDTH / 3
            scheduleLable.autoPinEdgeToSuperviewEdge(.Bottom)
            scheduleLable.autoPinEdgeToSuperviewEdge(.Top)
            scheduleLable.autoPinEdgeToSuperviewEdge(.Left)
            scheduleLable.autoSetDimension(.Width, toSize: lableWidth)
            
            attentionLable.autoPinEdgeToSuperviewEdge(.Bottom)
            attentionLable.autoPinEdgeToSuperviewEdge(.Top)
            attentionLable.autoMatchDimension(.Width, toDimension: .Width, ofView: scheduleLable)
            attentionLable.autoPinEdge(.Left, toEdge: .Right, ofView: scheduleLable)
  
            commentLable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Left)
            commentLable.autoMatchDimension(.Width, toDimension: .Width, ofView: scheduleLable)
            attentionLable.autoPinEdge(.Left, toEdge: .Right, ofView: attentionLable)
            
            lineLeft.autoPinEdgeToSuperviewEdge(.Top)
            lineLeft.autoPinEdgeToSuperviewEdge(.Bottom)
            lineLeft.autoSetDimension(.Width, toSize: 1)
            lineLeft.autoPinEdge(.Right, toEdge: .Right, ofView: scheduleLable)
            
            lineRight.autoPinEdgeToSuperviewEdge(.Top)
            lineRight.autoPinEdgeToSuperviewEdge(.Bottom)
            lineRight.autoSetDimension(.Width, toSize: 1)
            lineRight.autoPinEdge(.Left, toEdge: .Left, ofView: commentLable)

            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
