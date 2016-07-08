//
//  MarketGoods.swift
//  yinshijia
//
//  Created by Developer on 16/7/8.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MarketGoods: NSObject {
    
    var msg: String?

    var data: MarketGoodsData?

    var code: Int = 0
    
}

class MarketGoodsData: NSObject, YYModel {

    var status: Int = 0

    var title: String?

    var shop_introduce: String?

    var items: [Items]?

    var shareUrl: String?

    var to_date: String?

    var properties_image: String?

    var id: Int = 0

    var shop_headImage: String?

    var properties: [Properties]?

    var commentsNumber: Int = 0

    var cooker_id: Int = 0

    var subtitle: String?

    var head_image: String?

    var from_date: String?

    var comments: [Comments]?

    var exclusive_flag: Int = 0

    var book_info: String?

    var shop_nickName: String?

    var shop_shopName: String?

    var desp: String?
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["items": Items.classForCoder(),
                "properties": Properties.classForCoder(),
                "comments": Comments.classForCoder()]
    }
    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }

}

class Items: NSObject {

    var title: String?

    var goods_item_no: String?

    var price: Int = 0

}

class Properties: NSObject {

    var id: Int = 0

    var title: String?

    var value: String?

}

class Comments: NSObject {

    var imageurl: String?

    var content: String?

    var rank: Int = 0

    var user_id: String?

    var user_name: String?

    var createtime: String?

    var user_imageurl: String?

}

