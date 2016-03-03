//
//  ActivityViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit
import Alamofire

class ActivityViewController: UIViewController {
    @IBOutlet weak var bannerSv: UIScrollView!
    var activities:[Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.redColor()
        loadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        var params:Dictionary<String,AnyObject> = Dictionary()
        params["client_type"] = "iphone"
        params["num"] = "4"
        params["pa"] = "pa"
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/brand_theme_index", params: params, onSuccess: { (successData) -> Void in
                self.activities = Activity.saveDataToModel(successData["activities"])
                self.performSelector(Selector("loadBanner"), onThread: NSThread.mainThread(), withObject:self.activities, waitUntilDone: true)
            }) { (failData) -> Void in
                print(failData)
        }
    }
    
    func loadBanner(){
        print(self.activities.count)
        let image = UIImageView.init(image: UIImage.init())
        image.frame = CGRectMake(0, 0, self.bannerSv.frame.width, self.bannerSv.frame.height)
        if let activityImageUrl = activities[0].image_path {
            print(activityImageUrl)
            image.setWebImage(activityImageUrl , placeHolder: UIImage.init(named: "w_icon"))
        }
        self.bannerSv.addSubview(image)
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
