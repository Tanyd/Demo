//
//  BaseApi.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

typealias BaseApiCallBack = (result: AnyObject?,error: NSError?) -> ()
let BaseError = NSError(domain: "error", code: 0, userInfo: nil)


class BaseApi: AFHTTPSessionManager {
    
    enum RequestMethod: String{
        case GET = "GET"
        case POST = "POST"
    }
    
    private static let tools:BaseApi = {
        let t = BaseApi(baseURL: NSURL(string: Constant.Api.BaseUrl))
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain","text/html") as? Set<String>
        return t
    }()
    
    class func shareBaseApi() -> BaseApi {
        return tools
    }
    
    
    // 首页 api 请求
    func loadHomeChoiceBaseData(callBack: BaseApiCallBack) {
        let urlPath = Constant.Api.Home.BaseChoice
        request(.GET, Urlstring: urlPath, parameters: ["version" : Constant.Api.BaseVersion]) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = Choice.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
            
        }
    }
    
    
    func loadHomeChoiceMoreData(callBack: BaseApiCallBack, page: Int) {
        var path = Constant.Api.Home.MoreChoice
        let range = Range(start: path.endIndex.advancedBy(-3), end: path.endIndex.advancedBy(-2))
        path.replaceRange(range, with: String(page))
        request(.GET, Urlstring: path, parameters: ["version" : Constant.Api.BaseVersion]) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = ChoiceOnlyDinnerlists.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model?.data, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
        }
    }
    
    
    func loadHomeBaseChefData(callBack: BaseApiCallBack) {
        let urlPath = Constant.Api.Home.BaseChef
        request(.GET, Urlstring: urlPath, parameters: ["version" : Constant.Api.BaseVersion]) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = Chef.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
            
        }

    }
    
    func loadHomeChefListMoreData(callBack: BaseApiCallBack, page: Int, type: ChefSectionViewType) {
        var urlPath: String!
        if type == .chefHot {
            urlPath = Constant.Api.Home.HotChef
        }else {
            urlPath = Constant.Api.Home.NewChef
        }
        
        let range = Range(start: urlPath.endIndex.advancedBy(-3), end: urlPath.endIndex.advancedBy(-2))
        urlPath.replaceRange(range, with: String(page))
        
        request(.GET, Urlstring: urlPath, parameters: ["version" : Constant.Api.BaseVersion]) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = ChefList.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
        }

    }
    
    func loadGoodsData(callBack: BaseApiCallBack, page: Int) {
        var path = Constant.Api.Home.Goods
        let range = Range(start: path.endIndex.advancedBy(-3), end: path.endIndex.advancedBy(-2))
        path.replaceRange(range, with: String(page))
        request(.GET, Urlstring: path, parameters: ["version" : Constant.Api.BaseVersion]) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = Goods.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
        }

    }

    func loadChoiceListBaseData(callBack: BaseApiCallBack, id: Int){
        let urlPath = Constant.Api.Home.ChoiceList + String(id)
        request(.GET, Urlstring: urlPath, parameters: ["version" : Constant.Api.BaseVersion]) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = ChoiceList.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
        }
    }

    func request(method: RequestMethod, Urlstring: String,parameters: [String:AnyObject]?, finished: BaseApiCallBack){
        
        if method == RequestMethod.GET {
            
            GET(Urlstring, parameters: parameters, progress: nil , success: { ( _, result) -> Void in
                
                finished(result: result, error: nil)
                
                }, failure: { ( _, error) -> Void in
                    
                    DebugPrint(error)
//                    MBProgressHUD.showError("请检查您的网络设置")
                    finished(result: nil, error: error)
            })
            
        }else{
            
            POST(Urlstring, parameters: parameters, progress: nil, success: { (_, result) -> Void in
                
                finished(result: result, error: nil)
                
                }, failure: { (_, error) -> Void in
                    
                    DebugPrint(error)
//                    MBProgressHUD.showError("请检查您的网络设置")
                    finished(result: nil, error: error)
            })
        }
    }
    
}

