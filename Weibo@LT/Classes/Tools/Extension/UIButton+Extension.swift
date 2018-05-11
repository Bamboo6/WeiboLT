//
//  UIButton+Extension.swift
//  ssss
//
//  Created by Student on 17/9/14.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

extension UIButton {
    /// 便利构造函数
    /// - parameter imageName:     图像名称
    /// - parameter backImageName: 背景图像名称
    ///
    /// - returns: UIButton
    convenience init(imageName: String, backImageName: String?) {
        self.init()
        // 设置按钮图像
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        // 设置按钮背景图像
        if let backImageName = backImageName {
            setBackgroundImage(UIImage(named: backImageName), for: .normal)
            setBackgroundImage(UIImage(named: backImageName + "_highlighted"), for: .highlighted)
        }
        
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:          title
    /// - parameter color:          color
    /// - parameter backImageName:  背景图像
    ///
    /// - returns: UIButton
    convenience init(title: String, color: UIColor, backImageName: String) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        setBackgroundImage(UIImage(named: backImageName), for: .normal)
        
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter fontSize:  字体大小
    /// - parameter imageName: 图像名称
    /// - parameter backColor: 背景颜色（默认为nil）
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = nil) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        
        // 设置背景颜色
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
    }
}

