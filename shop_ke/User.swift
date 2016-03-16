//
//  User.swift
//  shop_ke
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation

//MARK:用户信息
class User {
    //获取用户信息
    static func fromDictionary(dict: NSDictionary ){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(dict, forKey: "User")
    }
}
