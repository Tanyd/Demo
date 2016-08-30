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
    private var centerBtn: CustomButton = {
        let btn = CustomButton(type: .Custom)
        btn.type = .ImgTop
        btn.margin = 7
        btn.setImage( UIImage(named: "custom_tabbar"), forState: .Normal)
        btn.setTitle("一键定制", forState: .Normal)
        btn.setTitleColor(Constant.Common.OrangeColor, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(11)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        shadowImage = UIImage()
        backgroundImage = UIImage(named: "tabar_bg")
        addSubview(centerBtn)
        centerBtn.action = {[weak self] in self?.centerBtnClick()}
    }
    
    func centerBtnClick() {
        if kdelegate != nil && (kdelegate?.respondsToSelector("tabbarCenterButtonClick"))!{
            kdelegate?.tabbarCenterButtonClick()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerBtn.center.x = width * 0.5
        centerBtn.center.y = 49 * 0.5 - 10
        centerBtn.frame.size = CGSize(width: (centerBtn.currentImage?.size.width)!, height: btnHeight + 20)
        var barItemIndex = 0
        for btn in subviews {
            if btn.isKindOfClass(UIControl) && btn != centerBtn {
                if barItemIndex == 2 {
                    barItemIndex += 1
                }
                btn.frame = CGRect(x: CGFloat(barItemIndex++) * btnWidth, y: 0, width: btnWidth, height: btnHeight)
            }
        }
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if !hidden {
            let newpoint = self.convertPoint(point, toView: centerBtn)
            if centerBtn.pointInside(newpoint, withEvent: event) {
                return centerBtn
            }else {
                return super.hitTest(point, withEvent: event)
            }
        }else{
            return super.hitTest(point, withEvent: event)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class textButton: UIButton {
    
    
}
