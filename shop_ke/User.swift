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
    var collect_activities : Int? = 0
    var flag: Int? = 0
    var message : String? = ""
    var notice :String? = ""
    var orders :Int? = 0
    var email : String? = ""
    var experience : Int? = 0
    var freeze_integral :Int? = 0
    var id : Int? = 0
    var img_url : String? = ""
    var integral : Int? = 0
    var join_time : String? = ""
    var name :String? = ""
    var nickname :String? = ""
    var phone : String? = ""
    var user_id :Int? = 0
    
    //获取用户信息
    static func fromDictionary(dict: NSDictionary ){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(dict, forKey: "User")
    }
}
