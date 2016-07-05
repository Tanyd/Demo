//
//  SVPHUD.swift
//  yinshijia
//
//  Created by Developer on 16/7/5.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

extension SVProgressHUD {
    
   class func showWithStatus(status: String!, maskType: SVProgressHUDMaskType!, style:  SVProgressHUDStyle!){
        showWithStatus(status)
        setDefaultMaskType(maskType)
        setDefaultStyle(style)
    }
}