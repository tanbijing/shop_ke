//
//  MeViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    var user:User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //设置用户名
        let userDefault = NSUserDefaults.standardUserDefaults()
        let dictionary = userDefault.objectForKey("User") as? NSDictionary
        
        print("\(userDefault.objectForKey("User") as? NSDictionary)")
        if let flag = dictionary?["flag"] as? Int where flag == 1 {
            self.userName.setTitle((dictionary!["web_user"]!["name"] as? String)!, forState: UIControlState.Normal)
            self.userName.enabled = false
        }else{
            self.userName.setTitle("登录正品折扣", forState: UIControlState.Normal)
            self.userName.enabled = true

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var userName: UIButton! //用户名

    @IBOutlet weak var headPic: UIImageView!//头像
    
    //MARK: 登陆
    @IBAction func login(sender: UIButton) {
        let nib=loginViewController()//需要跳转的viewcontroller
        self.presentViewController(nib, animated:true, completion: nil)
    }
    
    
    //MARK: 设置
    @IBAction func settingBtn(sender: UIButton) {
        let nib = SettingViewController()
        self.presentViewController(nib, animated: true, completion: nil)
    }
    
    
    
    
}



