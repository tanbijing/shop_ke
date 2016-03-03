//
//  WebImageCacheCenter.swift
//  shop_ke
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class FileUtility: NSObject {
    
    
    class func cachePath(fileName:String)->String
    {
        var arr =  NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        let path = arr[0]
        return "\(path)/\(fileName)"
    }
    
    
    class func imageCacheToPath(path:String,image:NSData)->Bool
    {
        return image.writeToFile(path, atomically: true)
    }
    
    class func imageDataFromPath(path:String)->AnyObject
    {
        let exist = NSFileManager.defaultManager().fileExistsAtPath(path)
        if exist
        {
            //var urlStr = NSURL.fileURLWithPath(path)
            _ = NSData(contentsOfFile: path);
            //var img:UIImage? = UIImage(data:data!)
            //return img ?? NSNull()
            let img = UIImage(contentsOfFile: path)
            
            let url:NSURL? = NSURL.fileURLWithPath(path)
            let dd = NSFileManager.defaultManager().contentsAtPath(url!.path!)
            _ = UIImage(data:dd!)
            
            if img != nil {
                return img!
            } else {
                return NSNull()
            }
        }
        
        return NSNull()
    }
    
    
    
    
}
