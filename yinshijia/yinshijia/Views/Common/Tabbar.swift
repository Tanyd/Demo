//
//  Tabbar.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
protocol TabbarDelegate: NSObjectProtocol {
    func tabbarCenterButtonClick()
}
class Tabbar: UITabBar {

    
    private let btnWidth: CGFloat = ScreenSize.SCREEN_WIDTH * 0.2
    private let btnHeight: CGFloat = 49
    weak var kdelegate: TabbarDelegate?
    private var centerBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setImage( UIImage(named: "custom_tabbar"), forState: .Normal)
        btn.setTitle("一键定制", forState: .Normal)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.sizeToFit()
        let imageSize = btn.imageView?.bounds.size
        let titleSize = btn.titleLabel?.bounds.size
        btn.imageEdgeInsets = UIEdgeInsetsMake(-imageSize!.height/2, titleSize!.width/2, imageSize!.height/2, -titleSize!.width/2)
        btn.titleEdgeInsets = UIEdgeInsetsMake(titleSize!.height/2 + 4, -imageSize!.width/2, -titleSize!.height/2, imageSize!.width/2)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        shadowImage = UIImage()
        backgroundImage = UIImage(named: "tabar_bg")
        addSubview(centerBtn)
        centerBtn.addTarget(self, action: "centerBtnClick", forControlEvents: .TouchUpInside)
    }
    
    func centerBtnClick() {
        if kdelegate != nil && (kdelegate?.respondsToSelector("tabbarCenterButtonClick"))!{
            kdelegate?.tabbarCenterButtonClick()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerBtn.center.x = width * 0.5
        centerBtn.center.y = 32
        var barItemIndex = 0
        for btn in subviews {
            if btn.isKindOfClass(UIControl) && btn != centerBtn {
                if barItemIndex == 2 {
                    barItemIndex++
                }
                btn.frame = CGRect(x: CGFloat(barItemIndex++) * btnWidth, y: 0, width: btnWidth, height: btnHeight)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
