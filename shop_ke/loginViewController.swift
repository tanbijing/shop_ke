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
        
        var params:Dictionary<String,AnyObject> = Dictionary()
        params["name"] = account.text
        params["pwd"] = password.text
        HttpManager.httpGetRequest(.POST, api_url: API_URL+"/login", params: params, onSuccess: {
            (successData) -> Void in
            print("JSON:\(successData)")
            if String(successData["flag"]) == "1"{
                self.MsgShow("登陆成功", action: {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }else{
                self.MsgShow("登录失败，请重新登录", action: {})
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
