//
//  UserAccount.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/25.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    
    /// 当前授权用户的UID
    var uid: String?
    
    /// access_token的生命周期，单位是秒数
    var expires_in: TimeInterval = 0{
        didSet {
            // 计算过期日期
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    /// 过期日期
    var expiresDate: NSDate?
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
    override var description: String {
        let keys = ["access_token","expires_in","uid","expiresDate"]
        return dictionaryWithValues(forKeys: keys).description
        
    }
}
