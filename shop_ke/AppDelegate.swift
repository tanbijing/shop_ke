//
//  AppDelegate.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //MARK:加载标签
    func loadTags(){
        //从接口获取标签保存至本地
        let params = [String : AnyObject]()
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/tag_list", params: params, onSuccess: { (successData) -> Void in
            Tag.saveTags(successData as! NSArray)
            }) { (failData) -> Void in
                print("保存标签失败")
        }
    }
    
    //MARK:加载左侧菜单栏
    func loadLeftMenu(){
        let params = [String : AnyObject]()
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/tag_and_sub_tag", params: params, onSuccess: { (successData) -> Void in
            print(successData)
            LeftMenu.loadLeftMenu(successData as! NSArray)
            }) { (failData) -> Void in
                print("保存左侧菜单栏失败")
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        loadTags()
        loadLeftMenu()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

