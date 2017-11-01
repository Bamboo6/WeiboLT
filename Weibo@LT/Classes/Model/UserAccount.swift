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
    /// 过期日期
    var expiresDate: NSDate?
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    /// access_token的生命周期，单位是秒数
    var expires_in: TimeInterval = 0{
        didSet {
            // 计算过期日期
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    var isRealName:Bool=false
    var remind_in:TimeInterval=0
    
    init(dict: [String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override var description: String {
        let keys = ["access_token","expires_in","uid","expiresDate","screen_name","avatar_large"]
        return dictionaryWithValues(forKeys: keys).description
        
    }
}
