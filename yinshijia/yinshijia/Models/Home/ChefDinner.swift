//
//  ChefDinner.swift
//  yinshijia
//
//  Created by Developer on 16/6/20.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefDinner: NSObject {
    
    var msg: String?

    var data: DinnerData?

    var code: Int = 0
    
    class func loadDetailDinner(callBack: BaseApiCallBack, id: Int) {
        BaseApi.shareBaseApi().loadDetailDinner(callBack, id: id)
    }
    
}
class DinnerData: NSObject, YYModel {

    var historyCustomMadeDinner: [Historycustommadedinner]?

    var shareContent: String?

    var openTime: [String]?

    var envImage: [Envimage]?

    var commentNum: Int = 0

    var isFavorite: Int = 0

    var historyDinner: [Historydinner]?

    var comment: [Comment]?

    var kitchenImage: [Kitchenimage]?

    var userId: Int = 0

    var baseInfo: Baseinfo?

    var menu: [Menu]?

    var amenities: [Amenities]?

    var plainMenu: [Plainmenu]?

    var environmentText: String?

    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["historyCustomMadeDinner": Historycustommadedinner.classForCoder(),
                "historyDinner": Historydinner.classForCoder(),
                "envImage": Envimage.classForCoder(),
                "comment": Comment.classForCoder(),
                "kitchenImage": Kitchenimage.classForCoder(),
                "menu": Menu.classForCoder(),
                "amenities": Amenities.classForCoder(),
                "plainMenu": Plainmenu.classForCoder()]
    }
}

class Baseinfo: NSObject, YYModel {

    var provinceName: String?

    var transportion_info: String?

    var introduce: String?

    var comment_flag: Int = 0

    var id: Int = 0

    var people_count: Int = 0

    var end_time: String?

    var max_people_count: Int = 0

    var address: String?

    var transportion_memo: String?

    var desp: String?

    var parking_info: String?

    var unit: String?

    var orderDescription: String?

    var tag: String?

    var history_dinner_flag: Int = 0

    var amenities: String?

    var addressDetail: String?

    var theme_image: String?

    var themeYinshijiaExtInfo: [String]?

    var name: String?

    var longitude: Double = 0

    var cooker_id: Int = 0

    var exclusive_flag: Int = 0

    var cityName: String?

    var imageurl: String?

    var price: Int = 0

    var shopName: String?

    var start_time: String?

    var districtName: String?

    var addressURL: String?

    var kitchen_id: Int = 0

    var city_id: Int = 0

    var huanjing_label: String?

    var title: String?

    var theme_images: String?

    var max_price: Int = 0

    var latitude: Double = 0

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
}

class Envimage: NSObject, YYModel {

    var image: String?

    var desp: String?

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
}

class Kitchenimage: NSObject, YYModel {

    var image: String?

    var desp: String?
    
    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }

}

class Amenities: NSObject {

    var id: Int = 0

    var name: String?

    var isBool: Int = 0

}

class Plainmenu: NSObject, YYModel {

    var title: String?

    var desp: String?
    
    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }

}

class Menu: NSObject, YYModel {

    var title: String?

    var image: String?

    var desp: String?

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
}


class Comment: NSObject {

    var userId: Int = 0

    var content: String?

    var datetime: String?

    var headImageurl: String?

    var title: String?

    var rank: Int = 0

    var shopName: String?

    var createtime: String?

    var name: String?

}

class Historycustommadedinner: NSObject {
    
    var imageurl: String?
    
    var shopName: String?
    
    var price: Int = 0
    
    var dinnertime: String?
    
    var name: String?
    
}

class Historydinner: NSObject {
    
    var dinnerId: Int = 0
    
    var title: String?
    
    var price: Int = 0
    
    var datetime: String?
    
    var imageurl: String?
    
}
