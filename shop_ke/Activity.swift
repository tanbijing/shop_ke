//
//  Activity.swift
//  shop_ke
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import Foundation
import UIKit

class Activity {
    var image_path:String?
    var image_url:String?
    var name:String?
    var url:String?
    
    static func saveDataToModel(data:AnyObject?)->[Activity]{
        var return_datas:[Activity] = []
        if let activities = data{
            for index in 0..<activities.count {
//                print(activities[index])
                let activity_data = activities[index]
                let activity = Activity()
                activity.image_path = String(activity_data["image_path"])
                activity.image_url = String(activity_data["image_url"])
                activity.name = String(activity_data["name"])
                activity.url = String(activity_data["url"])
                return_datas.append(activity)
            }
        }
        return return_datas
    }
}