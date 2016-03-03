//
//  loginViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class loginViewController: UIViewController ,UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        account.returnKeyType = UIReturnKeyType.Default
        account.delegate=self
        password.returnKeyType = UIReturnKeyType.Default
        password.delegate=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var account: UITextField!//账户

    @IBOutlet weak var password: UITextField!//密码
    
    //MARK:触摸键盘意外界面消失键盘
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.account.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    //MARK:
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    //MARK:注册操作
    @IBAction func register(sender: UIButton) {
        let nib = RegisterViewController()
        self.presentViewController(nib, animated: true, completion: nil)
    }
    
    //MARK:登陆操作
    @IBAction func loginBtn(sender: UIButton) {
        if self.account.text == "" || self.password.text == ""{
            self.MsgShow("请输入用户名或密码", action: {})
            return
        }
        
        var params = [String: AnyObject]()
        params["name"] = account.text
        params["pwd"] = password.text
        HttpManager.httpGetRequest(.POST, api_url: API_URL+"/login", params: params, onSuccess: {
            (successData) -> Void in
            print("JSON:\(successData)")
            print("\((successData["flag"])!)")
            
            if let flag = successData["flag"] as? Int where flag == 1 {
                print(flag)
            }
//            let temp = successData["flag"]
//            if successData["flag"] as! Int == 1 {
            if let flag = successData["flag"] as? Int where flag == 1 {
                self.MsgShow("登陆成功", action: {
                    self.dismissViewControllerAnimated(true, completion: nil)

                    let a = create()
                     let coll = successData["collect_actiities"] as? String
                    print(coll)
                    a.flag = String(successData["flag"]!!)
//                    a.message = (successData["message"] as? String)!
                    a.notice = String(successData["notice"]!!)
                    a.orders = String(successData["orders"]!!)
                    a.email = String(successData["email"])
                    a.experience = String(successData["experience"])
                    a.freeze_integral = String(successData["freeze_integral"])
                    a.id = String(successData["id"])
                    a.img_url = String(successData["web_user"]!!["img_url"]!!)
//                    a.img_url = (successData["web_user"] as? Dictionary)!["img_url"] as? String
                    a.integral = String(successData["integral"])
                    a.join_time = String(successData["join_time"])
//                    a.name = successData["name"] as! String
                    a.nickname = String(successData["nickname"])
                    a.phone = String(successData["phone"])
                    a.user_id = String(successData["user_id"])
                    print("\(a)")
                })
            }else{
                self.MsgShow("登录失败，请重新登录", action: {
                    self.account.text = ""
                    self.password.text = ""
                })
            }
            
        }) { (failData) -> Void in
            self.MsgShow("网络请求失败", action: {})
        }
    }
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: 提示框
    func MsgShow (MSG : String! , action : () ->()) {
        let alert = UIAlertController(title: "提示", message: "\(MSG)", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: {(headler: UIAlertAction!) in
            action()
        })
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }

}
