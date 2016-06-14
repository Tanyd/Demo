//
//  ChoiceList.swift
//  yinshijia
//
//  Created by Developer on 16/6/14.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChoiceList: NSObject {
    
    var msg: String?

    var data: ChoiceListData?

    var code: Int = 0
    
    class func loadChoiceListBaseData(callBack: BaseApiCallBack, id: Int) {
        BaseApi.shareBaseApi().loadChoiceListBaseData(callBack, id: id)
    }
}
class ChoiceListData: NSObject, YYModel {

    var shareUrl: String?

    var campaign: Campaign?

    var item: [Item]?

    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["item": Item.classForCoder()]
    }
}

class Campaign: NSObject, YYModel {

    var avaliable: Int = 0

    var subtitle: String?

    var id: Int = 0

    var title: String?

    var show_order: Int = 0

    var desp: String?

    var banner_image: String?

    var type: Int = 0

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
}

class Item: NSObject {

    var id: Int = 0

    var unit: String?

    var avaliable: Int = 0

    var show_order: Int = 0

    var dinner_type: Int = 0

    var theme_campaign_id: Int = 0

    var dinner_endOrderTime: String?

    var dinner_id: Int = 0

    var type: Int = 0

    var dinner_imageurl: String?

    var dinner_district: String?

    var dinner_maxCount: Int = 0

    var dinner_title: String?

    var dinner_datetime: String?

    var dinner_minCount: Int = 0

    var dinner_orderCount: Int = 0

    var dinner_price: Int = 0

}

