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
//        print("账户：＋＋＋＋\()")
        if User().flag == 1 {
        self.headPic.image = UIImage(named:"\(User().img_url)")
        print("图片名：\(User().img_url)")
            self.userName.setTitle(User().name!, forState: UIControlState.Normal)
            print(self.userName.titleLabel?.text)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



