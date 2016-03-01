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
        Alamofire.request(.GET, API_URL+"/brand_theme_index", parameters: params)
            .responseJSON { response in
                print("==============1")
                print(response.request)  // original URL request
                print("==============2")
                print(response.response) // URL response
                print("==============3")
                print(response.data)     // server data
                print("==============4")
                print(response.result)   // result of response serialization
                print("==============5")
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
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
