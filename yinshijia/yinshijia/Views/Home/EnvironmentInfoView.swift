//
//  EnvironmentInfoView.swift
//  yinshijia
//
//  Created by Developer on 16/6/20.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class EnvironmentInfoView: UIView {

    private var amenities = [Amenities](){
        didSet{
            setUI()
        }
    }
    
    private lazy var topImg: UIImageView = {
       return UIImageView()
    }()
    
    private var allBtns = [UIButton]()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func setUI() {
        addSubview(topImg)
        for index in 0...amenities.count - 1 {
            let btn = UIButton(type: .Custom)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30.0.fitWidth(), bottom: 0, right: 0)
            btn.setImage(UIImage(named: "amentity_unavailable"), forState: .Normal)
            btn.setImage(UIImage(named: "amentity_available"), forState: .Selected)
            btn.tag = index
            allBtns.append(btn)
            addSubview(btn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        var y: CGFloat = 0
        let constantX: CGFloat = 30.0.fitWidth()
        let btnWidth = 315.0.fitWidth()
        let btnHeight = 50.0.fitHeight()
        let constantY = 35.0.fitHeight()
        topImg.frame = CGRectMake(constantX, 40.0.fitHeight(), ScreenSize.SCREEN_WIDTH - constantX * 2, 550.0.fitHeight())
        for index in 0...allBtns.count - 1 {
            let btn = allBtns[index]
            x = constantY + CGFloat(index % 2) * btnWidth
            y = constantY + CGFloat(Int(index / 2) * Int(btnHeight))
            btn.frame = CGRectMake(x, y, btnWidth, btnHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
