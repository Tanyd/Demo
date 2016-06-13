//
//  Choice.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit


class Choice: NSObject {

    
    var msg: String?

    var data: Data?

    var code: Int = 0
    
    class func loadChoiceBaseData(callBack: BaseApiCallBack) {
        BaseApi.shareBaseApi().loadHomeChoiceBaseData(callBack)
    }
    
    class func loadChoiceMoreData(callBack: BaseApiCallBack, page: Int) {
        BaseApi.shareBaseApi().loadHomeChoiceMoreData(callBack, page: page)
    }
    
}

class Data: NSObject, YYModel{

    var banner: [Banner]?
    
    var catalog: [Catalog]?
    
    var dinnerList: [Dinnerlist]?
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["banner": Banner.classForCoder(),"catalog": Catalog.classForCoder(),"dinnerList":Dinnerlist.classForCoder()]
    }
}

//description -> desp
class Banner: NSObject, YYModel {

    var desp: String?

    var title: String?

    var banner_image: String?

    var type: Int = 0

    var subtitle: String?

    var bannerId: Int = 0

    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }
    
}

class Catalog: NSObject {
    
    var catalogImage: String?
    
    var catalogId: Int = 0
    
    var catalogTitle: String?
    
}

class Dinnerlist: NSObject {

    var dinnerId: Int = 0

    var maxCount: Int = 0

    var district: String?

    var title: String?

    var themeDinnerImageurl: String?

    var themeDinnerEndTime: String?

    var chefName: String?

    var endOrderTime: String?

    var themeDinnerChefName: String?

    var imageurl: String?

    var themeDinnerId: Int = 0

    var themeDinnerStartTime: String?

    var chefShopName: String?

    var themeDinnerUnit: String?

    var type: Int = 0

    var datetime: String?

    var chefImageurl: String?

    var themeDinnerDistrict: String?

    var minCount: Int = 0

    var chefId: Int = 0

    var themeDinnerChefImageurl: String?

    var themeDinnerMaxPrice: Int = 0

    var themeDinnerTitle: String?

    var themeDinnerChefId: Int = 0

    var themeDinnerChefShopName: String?

    var dinnerType: Int = 0

    var price: String?

    var themeDinnerMinPrice: Int = 0

    var orderCount: Int = 0

}

