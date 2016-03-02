//
//  HttpManager.swift
//  shop_ke
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation
import Alamofire
class HttpManager{
    static func httpGetRequest(method:Alamofire.Method,api_url:String,params:Dictionary<String,AnyObject>,onSuccess:(successData:AnyObject)->Void,onFailed:(failData:AnyObject)->Void){
        
        Alamofire.request(method, api_url, parameters: params)
            .responseJSON { response in
                if let JSON = response.result.value where response.result.isSuccess {
                    onSuccess(successData: JSON)
                }else{
                    onFailed(failData: "failed")
                }
        }
    }
}