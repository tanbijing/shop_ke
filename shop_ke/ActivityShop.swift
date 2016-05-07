//
//  ActivityShop.swift
//  shop_ke
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation

//MARK:活动商店数据
class ActivityShop {
    var discount = 0.0
    var name = ""
    var image_url = ""
    var activities:[Activity] = [] //获取到的定时跳转的图片数据形成一个数组
    
    static func getActivityShop(data:AnyObject?) ->[ActivityShop]{
        var shops = [ActivityShop]()
        if let arr = data!["hot_brands" ] as? [[String: AnyObject]] {
            for index in 0..<arr.count {
                let arr_data = arr[index]
                let shop = ActivityShop()
                shop.discount = arr_data["discount"] as! Double
                shop.name = arr_data["name"] as! String
                shop.image_url = arr_data["img_url"] as! String
                shops.append(shop)
            }
//            for (_,brand) in arr.enumerate() {
//                let shop = ActivityShop()
//                shop.discount = brand["discount"] as? Int
//                shop.name = brand["name"] as! String
//                shop.image_url = brand["img_url"] as! String
//                shops.append(shop)
//            }
        }
        return shops
    }
    
//    //加载数据
//    func loadData() {
//        var params = [String : AnyObject]()
//        params["client_type"] = "iphone"
//        params["num"] = "4"
//        params["pa"] = "pa"
//        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/brand_theme_index", params: params, onSuccess: { (successData) -> Void in
//            self.activities = Activity.saveDataToModel(successData["activities"])
//            self.loadBanner()
//            
//            self.shops = ActivityShop.getActivityShop(successData) //存商品数据
//            self.activityTableView.reloadData() //渲染表格
//        }) { (failData) -> Void in
//            print(failData)
//        }
//    }

    
}