//
//  UIButton+Extension.swift
//  ssss
//
//  Created by Student on 17/9/14.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(imageName: String,backImageName: String?) {
        self.init()
    
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"),for: .highlighted)
        
        setBackgroundImage(UIImage(named: backImageName!), for: .normal)
        setBackgroundImage(UIImage(named: backImageName!), for: .highlighted)
        sizeToFit()
    }
}
