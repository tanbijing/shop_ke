//
//  RegisterViewController.swift
//  shop_ke
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var accountRg: UITextField!//注册用户名
    
    @IBOutlet weak var passwordRg: UITextField!//注册密码
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:注册操作
    @IBAction func registerBtn(sender: UIButton) {
        if self.accountRg.text == "" || self.passwordRg.text == ""{
            //写提示“请输入用户名密码”
            return
        }
        
//        var params:Dictionary<String,AnyObject> = Dictionary()
//        
//        Alamofire.request(.GET,"", parameters:params)
    }


}
