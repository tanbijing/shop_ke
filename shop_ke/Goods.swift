//
//  Goods.swift
//  shop_ke
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation

class Goods {
//    var id :Int?
    var image : String?
//    var name : String?
    var content : String?
    var discount : Double?
    var price :Double?
    
    
    static func initWithGoods(data:AnyObject?)->[Goods]{
        var goods = [Goods]()
        if let arr = data{
            for index in 0..<arr.count {
                let arr_data = arr[index]
                let good = Goods()
                good.image = arr_data["img_url"] as? String
                good.content = arr_data["content"] as? String
                good.discount = arr_data["discount"] as? Double
                good.price = arr_data["price"] as? Double
                goods.append(good)
            }
            
        }
        
        return goods
    }
    
}