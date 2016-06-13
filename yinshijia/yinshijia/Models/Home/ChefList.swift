//
//  Chef.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/12.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefList: NSObject, YYModel {
    
    var msg: String?

    var data: [Cheflist]?

    var code: Int = 0
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["data": Cheflist.classForCoder()]
    }
    
    class func loadChefListMoreData(callBack: BaseApiCallBack, page: Int!, type: ChefSectionViewType) {
        BaseApi.shareBaseApi().loadHomeChefListMoreData(callBack, page: page!, type: type)
    }
}



