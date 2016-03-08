//
//  ProductViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var goodsScrollView: UIScrollView!
    @IBOutlet weak var goodsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.goodsScrollView.contentSize = self.goodsScrollView.bounds.size
        
        //从接口获取标签保存至本地
        let params = [String : AnyObject]()
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/tag_list?p=2", params: params, onSuccess: { (successData) -> Void in
            Tag.saveTags(successData as! NSArray)
            }) { (failData) -> Void in
                print("保存标签失败")
        }
        [self .loadTagView()]
        
        //创建一个cell放入内存以便重用
        goodsCollectionView.registerNib(UINib(nibName: "LogMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载scrollview的按钮
    func loadTagView(){
        
        let save = NSUserDefaults.standardUserDefaults()
        let arr = save.objectForKey("saveTags")
//        print(arr!)
//        print(arr!.count)
        
        var index :Int
        self.goodsScrollView.contentSize = CGSizeMake((CGFloat(arr!.count)*65), 30)
        for index = 0 ; index < arr!.count ; ++index {
            let btn = UIButton(type: .System)
//            print(arr![index]["name"])
            btn.frame = CGRectMake(CGFloat(Float(index)) * 65, 0, 65, 30)
            btn.setTitle((arr![index]["name"]) as? String, forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.redColor(),forState: .Highlighted)
            self.goodsScrollView.addSubview(btn)
        }
    }
    
    //MARK: 设置cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    //MARK:设置cell的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("12234777777")
    }
    
    //MARK: 跳转到分类
    @IBAction func logMenu(sender: UIButton) {
        let nib = LogMenuViewController()
        self.presentViewController(nib, animated: true, completion: nil)
    }

}
