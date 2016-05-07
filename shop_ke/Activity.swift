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
        let activities = data!["activities"] as! [[String:AnyObject]]
        for activity_data in activities {
            let activity = Activity()
            activity.image_path = activity_data["image_path"] as? String
            activity.image_url = activity_data["image_url"] as? String
            activity.name = activity_data["name"] as? String
            activity.url = activity_data["url"] as? String
            return_datas.append(activity)
        }
        return return_datas
    }
}