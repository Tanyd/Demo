//
//  ChefBanner.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/12.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class Chef: NSObject {

    var msg: String?

    var data: ChefData?

    var code: Int = 0
    
    class func loadChefBaseData(callBack: BaseApiCallBack) {
        BaseApi.shareBaseApi().loadHomeBaseChefData(callBack)
    }
    class func loadChefHotNewData(callBack: BaseApiCallBack, page: Int, type: ChefSectionViewType) {
        BaseApi.shareBaseApi().loadHomeChefListMoreData(callBack, page: page, type: type)
    }
    
    
}
class ChefData: NSObject, YYModel {

    var banner: [ChefBanner]?

    var chefList: [Cheflist]?
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["banner": ChefBanner.classForCoder(),"chefList": Cheflist.classForCoder()]
    }

}

class ChefBanner: NSObject, YYModel {

    var imageurl: String?

    var userId: String?

    var title: String?

    var dinnerId: String?

    var bannerId: Int = 0

    var type: Int = 0

    var desp: String?

    var h5url: String?

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
}

class Cheflist: NSObject {

    var userId: Int = 0

    var imageurl: String?

    var introduce: String?

    var shopName: String?

    var orderedCount: Int = 0

    var likeCount: Int = 0

    var name: String?

}

