//
//  ActivityViewController.swift
//  shop_ke
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit
import Alamofire

class ActivityViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var bannerSv: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var activities:[Activity] = []
    var bannerTime:NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.redColor()
        loadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        if scrollView != self.bannerSv{
            return
        }
        self.pageControl.currentPage = Int((scrollView.contentOffset.x-scrollView.frame.width)/scrollView.frame.width) + 1
    }
    
    func loadData(){
        var params:Dictionary<String,AnyObject> = Dictionary()
        params["client_type"] = "iphone"
        params["num"] = "4"
        params["pa"] = "pa"
        HttpManager.httpGetRequest(.GET, api_url: API_URL+"/brand_theme_index", params: params, onSuccess: { (successData) -> Void in
                self.activities = Activity.saveDataToModel(successData["activities"])
                self.performSelector(Selector("loadBanner"), onThread: NSThread.mainThread(), withObject:self.activities, waitUntilDone: true)
            }) { (failData) -> Void in
                print(failData)
        }
    }
    
    func loadBanner(){
        print(self.activities.count)
        for image in self.bannerSv.subviews{
            image.removeFromSuperview()
        }
        self.pageControl.numberOfPages = self.activities.count
        self.bannerSv.contentSize = CGSizeMake(self.bannerSv.frame.width*CGFloat(self.activities.count), self.bannerSv.frame.height)
        var pic_index = 0
        for activity in activities{
            let image = UIImageView.init(frame: CGRectMake(self.bannerSv.frame.width*CGFloat(pic_index), 0, self.bannerSv.frame.width, self.bannerSv.frame.height))
            if let activityImageUrl = activity.image_path {
                image.setWebImage(activityImageUrl , placeHolder: UIImage.init(named: "w_icon"))
            }
            self.bannerSv.addSubview(image)
            pic_index += 1
        }
        bannerTime = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("loopBannerImage"), userInfo: nil, repeats: true)
    }
    
    func loopBannerImage(){
        UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.bannerSv.setContentOffset(CGPointMake(self.bannerSv.contentOffset.x+self.bannerSv.frame.size.width, 0), animated: true)
            }) { (result) -> Void in
                print(self.pageControl.currentPage)
                if self.pageControl.currentPage==4{
                    self.bannerSv.setContentOffset(CGPointMake(0, 0), animated: true)
                }
        }
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.7f];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [sv setContentOffset:CGPointMake(rect.size.width * 2, 0.0f) animated:YES];
//        [UIView commitAnimations];
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
