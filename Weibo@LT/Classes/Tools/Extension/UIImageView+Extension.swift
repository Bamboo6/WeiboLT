//
//  UIImageView+Extension.swift
//  Weibo@LT
//
//  Created by LT on 2017/11/16.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

extension UIImageView{
    /// 便利构造函数
    /// - parameter imageName: imageName
    /// - returns: UIImageView
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
    }
}
