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
    
    let menuArray = LeftMenu.getMenu()
    var collection: [String:AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLeftMenu()
        
        //创建一个cell放入内存以便重用
        logCollectionView.registerNib(UINib(nibName: "leftMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //进入分类菜单默认是第一个分类
        collection = menuArray[0] as? [String : AnyObject]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载左侧分类菜单
    func loadLeftMenu(){
//        print(menuArray)
        logScrollView.contentSize = CGSizeMake(93,CGFloat(menuArray.count) * 60)
        for index in 0..<menuArray.count {
            let btn = UIButton(type: .System)
            if index == 0 {
                btn.tintColor = UIColor.redColor()
                btn.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }
            btn.frame = CGRectMake(0, CGFloat(index) * 60, 93, 60)
            btn.setTitle(menuArray[index]["name"] as? String, forState: UIControlState.Normal)
            btn.tintColor = UIColor.blackColor()
            btn.tag = index
            btn.addTarget(self, action: Selector("clickLeftMenu:"), forControlEvents: .TouchUpInside)
            logScrollView.addSubview(btn)
        }
    }
    
    //MARK:点击左侧分类菜单
    func clickLeftMenu(btn: UIButton) {
        let selectID = btn.tag
        collection = menuArray[selectID] as? [String: AnyObject]
        logCollectionView.reloadData()
        
        for (index,subviews) in logScrollView.subviews.enumerate() {
            if index == btn.tag {
                subviews.tintColor = UIColor.redColor()
                subviews.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }else {
                subviews.tintColor = UIColor.blackColor()
                subviews.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    //MARK: 返回
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MAKR:cell里面的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! leftMenuCollectionViewCell
        if  let collection = collection,
            let array = collection["sub_tag_group"] as? [AnyObject] {
            let groupKeys = array[indexPath.section]
            if let gps = groupKeys["group_key"] as? [AnyObject] {
                let groupKey = gps[indexPath.row]
                if let urlString = groupKey["img_url"] as? String,
                    let nameString = groupKey["sub_tag_name"] as? String {
//                    print("(\(indexPath.section),\(indexPath.row)): \(urlString)")
                    let image = UIImage(named: "zpzk")
                    cell.menuImage.setWebImage(urlString, placeHolder: image)
                    cell.menuName.text = nameString
                }
            }
        }
        return cell
    }
    
    //MARK:有多少组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let collection = collection,
            let group =  collection["sub_tag_group"] {
            return group.count
        } else {
            return 0
        }
    }
    
    //MARK:cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collection = collection,
            let subTagGroup = collection["sub_tag_group"],
            let dict = subTagGroup[section],
            let array = dict["group_key"] as? [AnyObject] {
            return array.count
        } else {
            return 0
        }
    }
    
    //MARK:点击cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("昂君")
    }
    
}
