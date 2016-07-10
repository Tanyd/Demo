//
//  Discover.swift
//  yinshijia
//
//  Created by Developer on 16/7/8.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class Discover: NSObject {
    
    var msg: String?

    var data: DiscoverData?

    var code: Int = 0
    
    class func loadDicoverBaseData(callBack: BaseApiCallBack) {
        BaseApi.shareBaseApi().loadDicoverBaseData(callBack)
    }
}

class DiscoverData: NSObject, YYModel {

    var chefs: [Chefs]?

    var catalogs: [Catalogs]?

    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["chefs": Chefs.classForCoder(),
                "catalogs": Catalogs.classForCoder()]
    }
}

class Chefs: NSObject {

    var userId: Int = 0

    var imageurl: String?

    var introduce: String?

    var favorite: Bool = false

    var shopName: String?

    var orderedCount: Int = 0

    var likeCount: Int = 0

    var name: String?

}

class Catalogs: NSObject {

    var catalogImage: String?

    var catalogId: Int = 0

    var catalogTitle: String?

}

