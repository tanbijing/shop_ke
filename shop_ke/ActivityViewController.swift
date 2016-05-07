//
//  ActivityViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit
import Alamofire

class ActivityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    @IBOutlet weak var bannerSv: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityTableView: UITableView!
    
    var activities:[Activity] = [] //获取到的定时跳转的图片数据形成一个数组
    var showBannerActivities:[Activity] = [] //从数据中取出三个形成一个固定的数组
    var bannerTime:NSTimer? = nil
    var shops = [ActivityShop]()  //商店数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.redColor()
        activityTableView.registerNib(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        bannerTime = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ActivityViewController.loopBannerImage), userInfo: nil, repeats: true)
        loadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        bannerTime?.invalidate()
        bannerTime = nil;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //当scrollcView的contentOffset发生变化时候开始调用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView != self.bannerSv{
            return
        }
        let x = scrollView.contentOffset.x;
        let currentPage = self.pageControl.currentPage
        //下一张
        if (x >= 2 * scrollView.frame.size.width)
        {
            if(currentPage==self.activities.count-1){
                self.pageControl.currentPage = 0;
            }else{
                self.pageControl.currentPage += 1
            }
            self.refreshBannerDatas()
        }
        //上一张
        if (x <= 0)
        {
            if(currentPage==0){
                self.pageControl.currentPage = self.activities.count-1;
            }else{
                self.pageControl.currentPage -= 1
            }
            self.refreshBannerDatas()
        }
    }
    
    //加载数据
    func loadData() {
        var params = [String : AnyObject]()
        params["client_type"] = "iphone"
        params["num"] = "4"
        params["pa"] = "pa"
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/brand_theme_index", params: params, onSuccess: { (successData) -> Void in
                self.activities = Activity.saveDataToModel(successData)
                self.loadBanner()
                self.shops = ActivityShop.getActivityShop(successData) //存商品数据
                self.activityTableView.reloadData() //渲染表格
            }) { (failData) -> Void in
                print(failData)
        }
    }
    
    //第一次加载banner数据
    func loadBanner() {
        //将scrollView里的所有组件移除
        for image in self.bannerSv.subviews{
            image.removeFromSuperview()
        }
        self.pageControl.numberOfPages = self.activities.count //设置page的总数量
        self.bannerSv.contentSize = CGSizeMake(self.bannerSv.frame.width*CGFloat(self.activities.count), self.bannerSv.frame.height)//设置scrollView滚动区域的大小
        self.changeBunnerShowDatas()
        for (pic_index,activity) in self.showBannerActivities.enumerate(){
            let image = UIImageView.init(frame: CGRectMake(self.bannerSv.frame.width*CGFloat(pic_index), 0, self.bannerSv.frame.width, self.bannerSv.frame.height))
            if let activityImageUrl = activity.image_path {
                image.setWebImage(activityImageUrl , placeHolder: UIImage.init(named: "w_icon"))
            }
            self.bannerSv.addSubview(image)
        }
        print(bannerSv.subviews.count)
        self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.frame.size.width, 0), animated: false)
        //判断定时器是否释放
        if ((bannerTime) != nil) {
            bannerTime!.invalidate()
            bannerTime = nil
        }
        bannerTime = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ActivityViewController.loopBannerImage), userInfo: nil, repeats: true)
    }
    
    //bunner滚动定时器
    func loopBannerImage() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.frame.size.width*CGFloat(2), 0), animated: true)
            }) { (result) -> Void in
                print("buner定时滚动:\(result)")
        }
    }
    
    //滚动到scrollView的端点后刷新bunner
    func refreshBannerDatas() {
        self.changeBunnerShowDatas()
        var scrollImages = self.bannerSv.subviews as! [UIImageView]

        for (index,activity) in self.showBannerActivities.enumerate() {
            if let activityImageUrl = activity.image_path {
                scrollImages[index].setWebImage(activityImageUrl , placeHolder: UIImage.init(named: "w_icon"))
            }
        }
        self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.frame.size.width,0), animated: false)
    }
    
    //根据当前的page改变要显示的bunner数据
    func changeBunnerShowDatas() {
        let currentPage = self.pageControl.currentPage
        switch currentPage{
            case 0:
                self.setShowActivities(self.activities.count-1, currentIndex: currentPage, lastIndex: currentPage+1)
            case self.activities.count-1:
                self.setShowActivities(currentPage-1, currentIndex: currentPage, lastIndex: 0)
            default:
                self.setShowActivities(currentPage-1, currentIndex: currentPage, lastIndex: currentPage+1)
        }
    }
    
    //重置bunner显示的活动数组
    func setShowActivities(firstIndex:Int,currentIndex:Int,lastIndex:Int) {
        print(self.activities.count)
        self.showBannerActivities.removeAll()
        self.showBannerActivities.append(self.activities[firstIndex])
        self.showBannerActivities.append(self.activities[currentIndex])
        self.showBannerActivities.append(self.activities[lastIndex])
    }
    
    //设置cell的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    //设置cell的内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ActivityTableViewCell
        let image = UIImage(named: "zpzk")
        let shop = shops[indexPath.row]
        cell.shopImage.setWebImage(shop.image_url, placeHolder: image)
        cell.shopDiscount.text = String(shop.discount)+"折起"
        cell.shopName.text = shop.name
        return cell
    }
    
    //cell行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }

}
