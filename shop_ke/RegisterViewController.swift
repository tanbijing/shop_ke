//
//  RegisterViewController.swift
//  shop_ke
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

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
        let nib = loginViewController()
        self.presentViewController(nib, animated:false , completion: nil)
    }
    
    //MARK:注册操作
    @IBAction func registerBtn(sender: UIButton) {
    
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
