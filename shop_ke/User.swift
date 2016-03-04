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
    static func fromDictionary(dict: NSDictionary ) ->User {
        let u = User()
        u.collect_activities = dict["collect_activities"] as? Int
        u.flag = dict["flag"] as? Int
        u.message = dict["message"]as? String
        u.notice = dict["notice"] as? String
        u.orders = dict["orders"] as? Int
        u.email = dict["web_user"]!["email"] as? String
        u.experience = dict["web_user"]!["experience"] as? Int
        u.freeze_integral = dict["web_user"]!["freeze_integral"] as? Int
        u.id = dict["web_user"]!["id"] as? Int
        u.img_url = dict["web_user"]!["img_url"] as? String
        u.integral = dict["web_user"]!["integral"] as? Int
        u.join_time = dict["web_user"]!["join_time"] as? String
        u.name = dict["web_user"]!["name"] as? String
        u.nickname = dict["web_user"]!["nickname"] as? String
        u.phone = dict["web_user"]!["phone"] as? String
        u.user_id = dict["web_user"]!["user_id"] as? Int
        return u;
    }
}
