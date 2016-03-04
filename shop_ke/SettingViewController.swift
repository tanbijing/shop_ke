//
//  SettingViewController.swift
//  shop_ke
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:是否推送
    @IBAction func isPush(sender: UISwitch) {
    
    }
    
    //MARK:退出账号
    @IBAction func exit(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("User")
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
