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
    
    var goods = [Goods]() //商品数据
    var refreshControl = UIRefreshControl() //下拉刷新
    let arr = Tag.getTags() //标签数据
    var detail = Detail() //商品详情数据
    var activityIndicatorView = UIActivityIndicatorView() //活动指示器
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //活动指示器
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)
        activityIndicatorView.hidden = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = UIColor.blackColor()
        self.view.addSubview(activityIndicatorView)

        loadTagView()
        loadProduct(6)

        //创建一个cell放入内存以便重用
        goodsCollectionView.registerNib(UINib(nibName: "LogMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //下拉刷新
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        refreshControl.tintColor = UIColor.redColor()
        goodsCollectionView.addSubview(refreshControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载标签
    func loadTagView() {
        var index :Int
        goodsScrollView.contentSize = CGSizeMake(CGFloat(arr.count)*65, 30)
        for index = 0 ; index < arr.count ; ++index {
            let btn = UIButton(type: .System)
            btn.frame = CGRectMake(CGFloat(Float(index)) * 65, 0, 65, 30)
            btn.setTitle((arr[index]["name"]) as? String, forState: UIControlState.Normal)
//            btn.setTitleColor(UIColor.redColor(),forState: .Highlighted)
            btn.tintColor = UIColor.blackColor()
            btn.tag = index
            btn.addTarget(self, action: Selector("tagClick:"), forControlEvents: .TouchUpInside)
            //使第一个颜色变红
            if index == 0 {
                btn.tintColor = UIColor.redColor()
            }
            goodsScrollView.addSubview(btn)
        }
    }
    
    //MARK:点击标签
    func tagClick(btn : UIButton) {
        print(btn.tag)
        //点击标签 根据标签id加载商品
        loadProduct(((arr[btn.tag]["id"]) as? Int)!)
        print(((arr[btn.tag]["id"]) as? Int)!)
        //点击标签变色
        for (index,subviews) in goodsScrollView.subviews.enumerate() {
            if index == btn.tag {
                subviews.tintColor = UIColor.redColor()
            }else {
                subviews.tintColor = UIColor.blackColor()
            }
        }
    }
    
    //MARK:加载商品
    func loadProduct(tagid : Int) {
        activityIndicatorView.startAnimating()
        
        var pramas = [String : AnyObject]()
        pramas["sort_type"] = "created_at-desc"
        pramas["tag_id"] = tagid
        pramas["page"] = 1
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/product_list", params: pramas, onSuccess: { (successData) -> Void in
                print("=======\(successData)")
                self.goods = Goods.initWithGoods(successData)
                self.goodsCollectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }) { (failData) -> Void in
                print("***********")
        }
    }
    
    //MARK:上拉刷新
//    func onPullToFresh(){
//
//    }
    
    //MARK:下拉刷新
    func refreshData() {
        self.goodsCollectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    //MARK: 设置cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.count;
    }
    
    //MARK:设置cell的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! LogMenuCollectionViewCell
        
        let image = UIImage(named: "zpzk")
        cell.goodsPicture.setWebImage(goods[indexPath.row].image!, placeHolder: image)
        cell.goodsDescribe.text = goods[indexPath.row].content
        cell.goodsPrice.text = "￥" + String(goods[indexPath.row].price!)
        cell.goodsDiscount.text = String(goods[indexPath.row].discount!)+"折"
        return cell
    }
    
    //MARK:点击cell后显示内容
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //根据商品id显示商品详情
        var params = [String: AnyObject]()
        params["id"] = goods[indexPath.row].id
        
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/product_detail", params: params, onSuccess: { (successData) -> Void in
            //获取点击的商品的数据
            self.detail = Detail.setDetail(successData)
            print(successData)
            let selectDetail = ProductDetailViewController()
            NSBundle.mainBundle().loadNibNamed("ProductDetailViewController", owner: selectDetail, options: nil)


            let image = UIImage(named: "zpzk")
            selectDetail.detailImage.setWebImage(self.detail.detailImage!, placeHolder: image)
            selectDetail.detailIntroduction.text = self.detail.detailIntroduction!
            selectDetail.discountPrice.text = "￥"+String(self.detail.discountPrice!)
            selectDetail.originalPrice.text = "原价:"+String(self.detail.originalPrice!)
            selectDetail.discount.text = self.detail.discount!+"折"
            selectDetail.detailUrl = self.detail.detailUrl!
            self.presentViewController(selectDetail, animated: true, completion: nil)
            }) { (failData) -> Void in
                print("获取失败！")
        }

    }
    
    //MARK: 跳转到分类
    @IBAction func logMenu(sender: UIButton) {
        let nib = LogMenuViewController()
        self.presentViewController(nib, animated: true, completion: nil)
    }

}
