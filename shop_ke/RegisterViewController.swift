//
//  RegisterViewController.swift
//  shop_ke
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController ,UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        accountRg.returnKeyType = UIReturnKeyType.Default
        accountRg.delegate=self
        passwordRg.returnKeyType = UIReturnKeyType.Default
        passwordRg.delegate=self
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
    
    //MARK:return确定返回
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        return true;
    }
    
    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:注册操作
    @IBAction func registerBtn(sender: UIButton) {
        if self.accountRg.text == "" || self.passwordRg.text == ""{
            self.MsgShow("请输入用户名或密码", action: {})
            return
        }
       // 发送注册接口请求
        var params = [String: AnyObject]()
        params["name"] = accountRg.text
        params["pwd"] = passwordRg.text
        HttpManager.httpGetRequest(.POST, api_url: API_URL+"/register", params: params, onSuccess: {
            (successData) -> Void in
                print("接口返回结果：\(successData)")
                self.MsgShow("注册成功", action: {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }) { (failData) -> Void in
                self.MsgShow("注册失败", action: {})
        }
        
//        Alamofire.request(.POST,API_URL+"/register", parameters:params)
//            .responseJSON{ response in
//                if let JSON = response.result.value{
//                    print("JSON:\(JSON)")
//                    self.MsgShow("注册成功", action: {
//                        self.dismissViewControllerAnimated(true, completion: nil)
//                    })
//                }else{
//                    self.MsgShow("注册失败", action: {})
//                }
//        }
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
