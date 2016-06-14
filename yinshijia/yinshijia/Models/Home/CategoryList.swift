//
//  CategoryList.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/14.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class CategoryList: NSObject, YYModel {
    
    var msg: String?

    var data: [CategoryListData]?

    var code: Int = 0
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["data": CategoryListData.classForCoder()]
    }
    
    class func loadCategoryListBaseData(callBack: BaseApiCallBack, id: Int) {
        BaseApi.shareBaseApi().loadCategoryListBaseData(callBack, id: id)
    }}

class CategoryListData: NSObject {

    var itemId: Int = 0

    var unit: String?

    var dinnerStartTime: String?

    var data: String?

    var dinnerPrice: String?

    var dinnerDistrict: String?

    var dinnerTitle: String?

    var type: Int = 0

    var dinnerImage: String?

    var dinnerEndTime: String?

    
}

