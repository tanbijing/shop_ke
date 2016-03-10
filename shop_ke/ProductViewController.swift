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
    
    var goods = [Goods]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTagView()

        //创建一个cell放入内存以便重用
        goodsCollectionView.registerNib(UINib(nibName: "LogMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        var pramas = [String : AnyObject]()
        pramas["sort_type"] = "created_at-desc"
        pramas["tag_id"] = 1
        pramas["page"] = 1
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/product_list?p=1", params: pramas, onSuccess: { (successData) -> Void in
            print("=======\(successData)")
            self.goods = Goods.initWithGoods(successData)
            self.goodsCollectionView.reloadData()
            }) { (failData) -> Void in
                print("***********")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载scrollview的按钮
    func loadTagView(){
        
        let save = NSUserDefaults.standardUserDefaults()
        let arr = save.objectForKey("saveTags")
        print(arr!)
        
        var index :Int
        self.goodsScrollView.contentSize = CGSizeMake((CGFloat(arr!.count)*65), 30)
        for index = 0 ; index < arr!.count ; ++index {
            let btn = UIButton(type: .System)
            btn.frame = CGRectMake(CGFloat(Float(index)) * 65, 0, 65, 30)
            btn.setTitle((arr![index]["name"]) as? String, forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.redColor(),forState: .Highlighted)
            self.goodsScrollView.addSubview(btn)
        }
    }
    
    //MARK: 设置cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.count;
    }
    
    //MARK:设置cell的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! LogMenuCollectionViewCell
//        print(goods[indexPath.row].image!)
        let image = UIImage(named: "zpzk")
        cell.goodsPicture.setWebImage(goods[indexPath.row].image!, placeHolder: image)
        cell.goodsDescribe.text = goods[indexPath.row].content
        cell.goodsPrice.text = String(goods[indexPath.row].price!)
        print(String(goods[indexPath.row].price))
        cell.goodsDiscount.text = String(goods[indexPath.row].discount!)+"折"
        return cell
    }
    
    //MARK:点击cell后显示内容
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("12234777777")
    }
    
    //MARK: 跳转到分类
    @IBAction func logMenu(sender: UIButton) {
        let nib = LogMenuViewController()
        self.presentViewController(nib, animated: true, completion: nil)
    }

}
