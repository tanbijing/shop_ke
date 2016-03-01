//
//  MeViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var headPic: UIImageView!
    @IBAction func login(sender: UIButton) {
        
        let nib=loginViewController()//需要跳转的viewcontroller
        self.presentViewController(nib, animated:true, completion: nil)
    }
    
    
    
    @IBAction func settingBtn(sender: UIButton) {
    }
    
    }



