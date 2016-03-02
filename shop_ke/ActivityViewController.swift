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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                print("success:\(successData)")
            }) { (failData) -> Void in
                print(failData)
        }
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
