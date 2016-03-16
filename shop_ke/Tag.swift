//
//  Tag.swift
//  shop_ke
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation

class Tag {
    
    //保存标签
    static func saveTags(arr:NSArray){
        let save = NSUserDefaults.standardUserDefaults()
        save.setObject(arr, forKey: "saveTags")
    }
    
    //获取标签
    static func getTags() ->NSArray{
        let tags = NSUserDefaults.standardUserDefaults()
        let arr = tags.objectForKey("saveTags") as? NSArray
        return arr!
    }
}