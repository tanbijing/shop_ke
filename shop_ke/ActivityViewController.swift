//
//  ActivityViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit
import Alamofire

class ActivityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var bannerSv: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityTableView: UITableView!
    
    var activities:[Activity] = []
    var showBannerActivities:[Activity] = []
    var bannerTime:NSTimer? = nil
    var shops = [ActivityShop]()  //商店数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.redColor()
        loadData()
        
        activityTableView.registerNib(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        bannerTime = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("loopBannerImage"), userInfo: nil, repeats: true)
        
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
    
    func loadData(){
        var params:Dictionary<String,AnyObject> = Dictionary()
        params["client_type"] = "iphone"
        params["num"] = "4"
        params["pa"] = "pa"
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/brand_theme_index", params: params, onSuccess: { (successData) -> Void in
                print(successData)
                self.activities = Activity.saveDataToModel(successData["activities"])
                self.performSelector(Selector("loadBanner"), onThread: NSThread.mainThread(), withObject:self.activities, waitUntilDone: true)
            
                self.shops = ActivityShop.getActivityShop(successData) //存商品数据
                self.activityTableView.reloadData() //渲染表格
                print(self.shops)
            }) { (failData) -> Void in
                print(failData)
        }
    }
    //第一次加载banner数据
    func loadBanner(){
        for image in self.bannerSv.subviews{
            image.removeFromSuperview()
        }
        self.pageControl.numberOfPages = self.activities.count
        self.bannerSv.contentSize = CGSizeMake(self.bannerSv.frame.width*CGFloat(self.activities.count), self.bannerSv.frame.height)
        self.changeBunnerShowDatas()
        var pic_index = 0
        for activity in self.showBannerActivities{
            let image = UIImageView.init(frame: CGRectMake(self.bannerSv.frame.width*CGFloat(pic_index), 0, self.bannerSv.frame.width, self.bannerSv.frame.height))
            if let activityImageUrl = activity.image_path {
                image.setWebImage(activityImageUrl , placeHolder: UIImage.init(named: "w_icon"))
            }
            self.bannerSv.addSubview(image)
            pic_index += 1
        }
        self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.frame.size.width, 0), animated: false)
        //判断定时器是否释放
        if ((bannerTime) != nil) {
            bannerTime!.invalidate()
            bannerTime = nil
        }
        bannerTime = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("loopBannerImage"), userInfo: nil, repeats: true)
    }
    //bunner滚动定时器
    func loopBannerImage(){
        UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.frame.size.width*CGFloat(2), 0), animated: true)
            }) { (result) -> Void in
                print("buner定时滚动:\(result)")
        }
    }
    //滚动到scrollView的端点后刷新bunner
    func refreshBannerDatas(){
        self.changeBunnerShowDatas()
        var scrollImages = self.bannerSv.subviews as! [UIImageView]
        var activity_index = 0
        for activity in self.showBannerActivities {
            if let activityImageUrl = activity.image_path {
                scrollImages[activity_index].setWebImage(activityImageUrl , placeHolder: UIImage.init(named: "w_icon"))
                activity_index += 1
            }
        }
        self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.frame.size.width,0), animated: false)
    }
    //根据当前的page改变要显示的bunner数据
    func changeBunnerShowDatas(){
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
    func setShowActivities(firstIndex:Int,currentIndex:Int,lastIndex:Int){
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
        print(shop.discount)
        cell.shopName.text = shop.name
        print(shop.name)
        return cell
    }
    
    //cell行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }

}
