//
//  CustomButton.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
    
    enum CustomButtonType {
        case ImgTop
        case ImgRight
    }
    
    var type: CustomButtonType!
    
    var margin: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .Center
        imageView?.contentMode = .Center
        titleLabel?.contentMode = .Center
      
        switch type!{
        case CustomButtonType.ImgRight:
            titleLabel?.frame.origin.x = 0
            imageView?.frame.origin.x = titleLabel!.frame.size.width + margin
        default:
            imageView?.frame.origin.y = 0
            imageView?.frame.origin.x = 0
            titleLabel?.frame.size.width = frame.size.width
            titleLabel?.frame.origin.x = 0
            titleLabel?.frame.origin.y = imageView!.frame.size.height + margin
        }
    }
}
