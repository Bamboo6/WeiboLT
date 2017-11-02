//
//  UserAccountViewModel.swift
//  Weibo@LT
//
//  Created by LT on 2017/11/2.
//  Copyright © 2017年 LT. All rights reserved.
//

import Foundation

class UserAccountViewModel {
    /// 用户模型
    var account: UserAccount?
    
    /// 归档保存的路径 - 计算型属性(类似于有返回值的函数，可以在调用的时候，语义会更清晰)
    private var accountPath: String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return (path as NSString).appendingPathComponent("account.plist")
    }
    
    /// 构造函数
    init() {
        //从沙盒解档数据，恢复当前数据
        account = NSKeyedUnarchiver.unarchiveObject(with: accountPath)as? UserAccount
        print(account)
        
        // 判断token是否过期
        if isExpired {
            print("已经过期")
            // 如果过期，清空解档的数据
            account = nil
        }
    }
    
    /// 判断账户是否过期
    private var isExpired: Bool {
        // 如果 account 为 nil，不会访问后面的属性，后面的比较也不会继续
        if account?.expiresDate?.compare(NSDate() as Date) == ComparisonResult.orderedDescending {
            // 代码执行到此，一定进行过比较！
            return false
        }
        // 如果过期返回 true
        return true
    }
    
}
