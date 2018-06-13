//
//  Status.swift
//  Weibo@LT
//
//  Created by LT on 2018/3/23.
//  Copyright © 2018年 LT. All rights reserved.
//

import UIKit

class Status: NSObject {
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 微博创建时间
    var created_at: String?
    //用户模型
    var user: User?
    /// 缩略图配图数组 key: thumbnail_pic
    var pic_urls: [[String: String]]?
    /// 被转发的原微博信息字段
    var retweeted_status: Status?
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    // 为了有效地将字典转为模型
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["id","text","created_at","source","user","pic_urls","retweeted_status"]
        return dictionaryWithValues(forKeys: keys).description
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        //判断key是否是user
        if key == "user"{
            if let dict = value as? [String:AnyObject]{
                user = User(dict:dict) // 字典转换成模型
            }
            return
        }
        
        // 判断 key 是否等于 retweeted_status
        if key == "retweeted_status" {
            if let dict = value as? [String: AnyObject] {
                retweeted_status = Status(dict: dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }
}
