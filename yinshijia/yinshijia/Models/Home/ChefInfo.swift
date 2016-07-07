//
//  ChefInfo.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfo: NSObject {
    
    var msg: String?

    var data: ChefInfoData?

    var code: Int = 0
    
    class func loadChefInfo(callBack: BaseApiCallBack, id: Int) {
        BaseApi.shareBaseApi().loadChefInfo(callBack, id: id)
    }
}

class ChefInfoData: NSObject, YYModel {

    var themeDinner: [Themedinner]?

    var shareContent: String?

    var openTime: [String]?

    var commentNum: Int = 0

    var isFavorite: Int = 0

    var historyDinner: [Historydinner]?

    var comment: [ChefInfoComment]?

    var kitchenImage: [ChefInfoKitchenimage]?

    var userId: Int = 0

    var address: Address?

    var baseInfo: ChefInfoBaseinfo?

    var menu: [Menu]?

    var goods: [ChefInfoGoods]?

    var historyCustomMadeDinner: [Historycustommadedinner]?

    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["themeDinner": Themedinner.classForCoder(),
                "historyDinner": Historydinner.classForCoder(),
                "comment": ChefInfoComment.classForCoder(),
                "kitchenImage": ChefInfoKitchenimage.classForCoder(),
                "menu": Menu.classForCoder(),
                "goods": ChefInfoGoods.classForCoder(),
                "historyCustomMadeDinner": Historycustommadedinner.classForCoder()]
    }
}

class Address: NSObject {

    var latitude: Double = 0

    var longitude: Double = 0

    var mapImageUrl: String?

    var address: String?

}

class ChefInfoBaseinfo: NSObject {

    var introduce: String?

    var name: String?

    var environmentText: String?

    var headImageurl: String?

    var custom_order_flag: String?

    var shopName: String?

    var orderedCount: Int = 0

    var likeCount: Int = 0

    var converurl: String?

    var tags: String?

}

class ChefInfoKitchenimage: NSObject, YYModel {

    var desp: String?

    var environmenturl: String?

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
}

class Themedinner: NSObject {

    var unit: String?

    var themeImage: String?

    var minPeopleCount: Int = 0

    var minPrice: Int = 0

    var title: String?

    var themeId: Int = 0

    var endTime: String?

    var address: String?

    var district: String?

    var maxPeopleCount: Int = 0

    var startTime: String?

    var maxPrice: Int = 0

}

class ChefInfoComment: Comment {
    
    var imageurl: String?
    
    var dinnertime: String?
}

class ChefInfoGoods: NSObject {
    
    var goodsId: Int = 0
    
    var propertiesImage: String?
    
    var title: String?

    var subtitle: String?

}

