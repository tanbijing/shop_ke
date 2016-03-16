//
//  HeaderReusableView.swift
//  shop_ke
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

//创建一个分组头视图view
class HeaderReusableView: UICollectionReusableView  {
    var headerLb:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLb=UILabel()
        headerLb.frame=CGRectMake(10, 0, 262, 20)
//        headerLb.backgroundColor=UIColor.yellowColor()
        headerLb.textColor = UIColor.redColor()
        self.addSubview(headerLb)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
