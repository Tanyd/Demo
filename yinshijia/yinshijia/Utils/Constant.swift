//
//  Constant.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//


// 精选下拉刷新  http://api.yinshijia.com/mobile/apiv2/index/choice/1
// 精选上啦刷新  http://api.yinshijia.com/mobile/apiv2/index/choiceDinner/1/1/8
// 精选banner   http://api.yinshijia.com/mobile/apiv2/index/campaignItem/50
// 分类按钮      http://api.yinshijia.com/mobile/apiv2/index/catalog/20
// 主厨 newChef http://api.yinshijia.com/mobile/apiv2/index/chefList/new/1/1/8
// 主厨 hotChef http://api.yinshijia.com/mobile/apiv2/index/chefList/hot/1/1/8
// 主厨 Base    http://api.yinshijia.com/mobile/apiv2/index/chef/1
// 市集         http://api.yinshijia.com/mobile/apiv2/goods/list/1/8


import UIKit

let IS_DEBUG = true

func DebugPrint(obj: Any) {
    if IS_DEBUG {
        print(obj)
    }
}


struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_AVAILABLE_HEIGHT = SCREEN_HEIGHT - 114
    static let SCREEN_TOP_EDGE = 64
}

struct Constant {
    
    struct Common {
        
        static let OrangeColor = UIColor.colorFromHex(0xfe8a71)
        
        static let GrayColor = UIColor.colorFromHex(0x6f6f70)
        
        static let DefaultFont = "HelveticaNeue"
        
        static let BoldFont = "HelveticaNeue-Bold"
        
        static let MediumFont = "HelveticaNeue-Medium"
        
        static let LightFont = "HelveticaNeue-Light"
        
    }
    
    struct NotificationName {
        static let TableDidScroll = "TableDidScroll"
    }
    
    
    struct Api {
        
        static let BaseUrl = "http://api.yinshijia.com/mobile/apiv2/"
        
        static let BaseVersion = "3.4.3"

        struct Home {
            
            static let BaseChoice = "index/choice/1"
            
            static let MoreChoice = "index/choiceDinner/1/1/8"
            
            static let BaseChef = "index/chef/1"
            
            static let HotChef = "index/chefList/hot/1/1/8"
            
            static let NewChef = "index/chefList/new/1/1/8"
            
            static let Goods = "goods/list/1/8"
            
            static let ChoiceList = "index/campaignItem/"
            
            static let CategoryList = "index/catalog/"
        }
    }
}