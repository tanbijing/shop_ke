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
    var discount = 0
    var name = ""
    var image_url = ""
    
    static func getActivityShop(data:AnyObject?) ->[ActivityShop]{
        var shops = [ActivityShop]()
        if let arr = data!["hot_brands" ] as? [[String: AnyObject]] {
            for index in 0..<arr.count {
                let arr_data = arr[index]
                let shop = ActivityShop()
                shop.discount = arr_data["discount"] as! Int
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
    
    
}