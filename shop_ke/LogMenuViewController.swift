//
//  LogMenuViewController.swift
//  shop_ke
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class LogMenuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var logCollectionView: UICollectionView!
    @IBOutlet weak var logScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLeftMenu()
        
        //创建一个cell放入内存以便重用
        logCollectionView.registerNib(UINib(nibName: "LogMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载左侧分类菜单
    func loadLeftMenu(){
        let left = NSUserDefaults.standardUserDefaults()
        let arr = left.objectForKey("leftMenu")
        
        logScrollView.contentSize = CGSizeMake(93,CGFloat(arr!.count) * 60)
        for  var index : Int = 0 ; index < arr!.count ; ++index{
            let btn = UIButton(type: .System)
            btn.frame = CGRectMake(0, CGFloat(index) * 60, 93, 60)
            btn.setTitle(arr![index]["name"] as? String, forState: UIControlState.Normal)
            btn.tag = (arr![index]["id"] as? Int)!
            logScrollView.addSubview(btn)
        }
    }
    
    //MARK: 返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MAKR:cell里面的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
    //MARK:cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK:点击cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("昂君")
    }

}
