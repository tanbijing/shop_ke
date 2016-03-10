//
//  LogMenuCollectionViewCell.swift
//  shop_ke
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 peraytech. All rights reserved.
//

import UIKit

class LogMenuCollectionViewCell: UICollectionViewCell {

    

    @IBOutlet weak var goodsPicture: UIImageView!
    @IBOutlet weak var goodsDescribe: UILabel!
    @IBOutlet weak var goodsPrice: UILabel!
    @IBOutlet weak var goodsDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
