//
//  Goods.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/13.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class Goods: NSObject, YYModel {

    var msg: String?

    var data: [GoodsData]?

    var code: Int = 0
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["data": GoodsData.classForCoder()]
    }

    class func loadGoodsData(callBack: BaseApiCallBack, page: Int){
        BaseApi.shareBaseApi().loadGoodsData(callBack, page: page)
    }
}
class GoodsData: NSObject, YYModel {

    var subtitle: String?

    var status: Int = 0

    var title: String?

    var goodsId: Int = 0

    var properties_image: String?

    var desp: String?
    
    static func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desp":"description"]
    }

}

