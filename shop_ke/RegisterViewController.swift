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
    

    //MARK:触摸键盘意外界面消失键盘
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.accountRg.resignFirstResponder()
        self.passwordRg.resignFirstResponder()
    }
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:注册操作
    @IBAction func registerBtn(sender: UIButton) {
        if self.accountRg.text == "" || self.passwordRg.text == ""{
            self.MsgShow("请输入用户名或者密码")
            return
        }
        
        //发送注册接口请求
        var params:Dictionary<String,AnyObject> = Dictionary()
        params["name"] = accountRg.text
        params["pwd"] = passwordRg.text
        
        Alamofire.request(.POST,API_URL+"/register", parameters:params)
            .responseJSON{ response in
                print("=============1")
                print(response.request)
                print("=============2")
                print(response.response)
                print("=============3")
                print(response.data)
                print("=============4")
                print(response.result)
                print("=============5")
                if let JSON = response.result.value{
                    print("JSON:\(JSON)")
                    self.MsgShow("注册成功")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    self.MsgShow("注册失败")
                }
        }
    }

    //MARK: 提示框
    func MsgShow (MSG : String) {
        let alert = UIAlertView(title: "提示", message: "\(MSG)", delegate: self, cancelButtonTitle: "确定")
        alert.alertViewStyle = UIAlertViewStyle.Default
        alert.show()
    }

}
