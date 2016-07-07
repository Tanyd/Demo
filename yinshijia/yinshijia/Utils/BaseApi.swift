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
    
    //MARK: 首页 api 请求
    func loadHomeChoiceBaseData(callBack: BaseApiCallBack) {
        loadBaseData(callBack, urlPath: Constant.Api.Home.BaseChoice, classType: Choice.classForCoder())
    }
    
    func loadHomeChoiceMoreData(callBack: BaseApiCallBack, page: Int) {
        loadMoreDataWithPage(callBack, urlPath: Constant.Api.Home.MoreChoice, page: page, classType: ChoiceOnlyDinnerlists.classForCoder())
    }
    
    func loadHomeBaseChefData(callBack: BaseApiCallBack) {
        loadBaseData(callBack, urlPath: Constant.Api.Home.BaseChef, classType: Chef.classForCoder())
    }
    
    func loadHomeChefListMoreData(callBack: BaseApiCallBack, page: Int, type: ChefSectionViewType) {
        let urlPath = (type == .chefHot) ? Constant.Api.Home.HotChef : Constant.Api.Home.NewChef
        loadMoreDataWithPage(callBack, urlPath: urlPath, page: page, classType: ChefList.classForCoder())
    }
    
    func loadGoodsData(callBack: BaseApiCallBack, page: Int) {
        loadMoreDataWithPage(callBack, urlPath: Constant.Api.Home.Goods, page: page, classType: Goods.classForCoder())
    }

    func loadChoiceListBaseData(callBack: BaseApiCallBack, id: Int) {
        loadBaseDataWithID(callBack, urlPath: Constant.Api.Home.ChoiceList, id: id, classType: ChoiceList.classForCoder())
    }

    func loadCategoryListBaseData(callBack: BaseApiCallBack, id: Int) {
        loadBaseDataWithID(callBack, urlPath: Constant.Api.Home.CategoryList, id: id, classType: CategoryList.classForCoder())
    }
    
    func loadDetailDinner(callBack: BaseApiCallBack, id: Int) {
        loadBaseDataWithID(callBack, urlPath: Constant.Api.Home.DetailDinner, id: id, classType: ChefDinner.classForCoder())
    }
    
    func loadChefInfo(callBack: BaseApiCallBack, id: Int) {
        loadBaseDataWithParameters(callBack, urlPath: Constant.Api.Home.ChefInfo, parameters: Constant.Api.TokenParameters, id: id, classType: ChefInfo.classForCoder())
    }
    
    //MARK: base 请求
    func loadBaseData(callBack: BaseApiCallBack, urlPath: String, classType: AnyClass) {
        loadBaseDataWithID(callBack, urlPath: urlPath, id: nil, classType: classType)
    }
    
    //MARK: 拼接参数ID 请求
    func loadBaseDataWithID(callBack: BaseApiCallBack, urlPath: String, id: Int?, classType: AnyClass) {
        loadBaseDataWithParameters(callBack, urlPath: urlPath, parameters: nil, id: id, classType: classType)
    }
    
    //MARK: 分页更多 请求
    func loadMoreDataWithPage(callBack: BaseApiCallBack,var urlPath: String,page: Int, classType: AnyClass) {
        let range = Range(start: urlPath.endIndex.advancedBy(-3), end: urlPath.endIndex.advancedBy(-2))
        urlPath.replaceRange(range, with: String(page))
        request(.GET, Urlstring: urlPath, parameters: Constant.Api.BaseParameters) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = classType.yy_modelWithJSON(json.dictionaryObject!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
        }
    }
    
    func loadBaseDataWithParameters(callBack: BaseApiCallBack, urlPath: String, parameters: [String:AnyObject]?, id: Int?, classType: AnyClass){
        var dic: [String:AnyObject]?
        if parameters == nil {
            dic = Constant.Api.BaseParameters
        }else{
            dic = parameters
            dic![Constant.Api.BaseParameters.keys.first!] = Constant.Api.BaseParameters.values.first!
        }
        let path: String?
        if id != nil {
            path = urlPath + String(id!)
        }else{
            path = urlPath
        }
        request(.GET, Urlstring: path!, parameters: dic) { (result, error) in
            if error != nil {
                callBack(result: nil, error: error)
            }else{
                let json = JSON(result!)
                let code = json["code"].number
                if code == 200 {
                    let model = classType.yy_modelWithJSON(result!)
                    callBack(result: model, error: nil)
                }else{
                    callBack(result: nil, error: BaseError)
                }
            }
        }
    }
    
    //MARK: base api request
    func request(method: RequestMethod, Urlstring: String,parameters: [String:AnyObject]?, finished: BaseApiCallBack){
      
        if method == RequestMethod.GET {
            
            GET(Urlstring, parameters: parameters, progress: nil , success: { ( _, result) -> Void in
                print("URL=\(Constant.Api.BaseUrl)" + "\(Urlstring)")
                print("parameters=\(parameters)")
                print("Result=\(result)")
                finished(result: result, error: nil)
                
                }, failure: { ( _, error) -> Void in
                    
                    DebugPrint(error)
                    finished(result: nil, error: error)
            })
            
        }else{
            
            POST(Urlstring, parameters: parameters, progress: nil, success: { (_, result) -> Void in
                print("URL=\(Constant.Api.BaseUrl)" + "\(Urlstring)")
                print("parameters=\(parameters)")
                print("Result=\(result)")
                finished(result: result, error: nil)
                
                }, failure: { (_, error) -> Void in
                    
                    DebugPrint(error)
                    finished(result: nil, error: error)
            })
        }
    }
}

