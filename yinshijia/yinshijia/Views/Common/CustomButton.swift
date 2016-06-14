//
//  CustomButton.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class LeftImgButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 4
    }
}


class UpImgButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
        imageView?.contentMode = .Center
        titleLabel?.textAlignment = .Center
        contentMode = .Center
        imageView?.frame.origin.y = 0
        imageView?.frame.origin.x = 0
        titleLabel?.frame.origin.x = 0
        titleLabel?.frame.origin.y = imageView!.frame.size.height
    }
}
