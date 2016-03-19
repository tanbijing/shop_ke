//
//  ProductDetailViewController.swift
//  shop_ke
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailIntroduction: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    var detailUrl :String?
    
//    init() {
//        super.init(nibName: "ProductDetailViewController", bundle: nil)
//        NSBundle.mainBundle().loadNibNamed("ProductDetailViewController", owner: self, options: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        detailImage.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:跳转到购物页面
    @IBAction func buy(sender: UIButton) {
        let urlString = self.detailUrl
        let url = NSURL(string: urlString!)
        UIApplication.sharedApplication().openURL(url!)
    }
}
