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
    //用户模型
    var user:User?
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    // 为了有效地将字典转为模型
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["id","text","created_at","source","user"]
        return dictionaryWithValues(forKeys: keys).description
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        //判断key是否是user
        if key == "user"
        {
            if let dict = value as? [String:AnyObject]
            {
                user=User(dict:dict) // 字典转换成模型
            }
            return
        }
        super.setValue(value, forKey: key)
    }
}
