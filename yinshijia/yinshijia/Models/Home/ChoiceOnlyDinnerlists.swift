//
//  ChoiceOnlyDinnerlists.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChoiceOnlyDinnerlists: NSObject, YYModel {

    
    var msg: String?

    var data: [Dinnerlist]?

    var code: Int = 0
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["data": Dinnerlist.classForCoder()]
    }
    
}


