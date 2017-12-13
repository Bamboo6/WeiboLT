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
    public var accountPath: String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
//        return (path as NSString).appendingPathComponent("account.plist")
        return (path as NSString).strings(byAppendingPaths: ["account.plist"]).last!
    }
    
    /// 构造函数 - 私有化
    private init() {
        //从沙盒解档数据，恢复当前数据
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath)as? UserAccount
        print(account)
        
        // 判断token是否过期
        if isExpired {
            print("已经过期")
            // 如果过期，清空解档的数据
            account = nil
        }
    }
    
    /// 判断账户是否过期
    public var isExpired: Bool {
        // 如果 account 为 nil，不会访问后面的属性，后面的比较也不会继续
        if account?.expiresDate?.compare(NSDate() as Date) == ComparisonResult.orderedDescending {
            // 代码执行到此，一定进行过比较！
            return false
        }
        // 如果过期返回 true
        return true
    }
    
    /// 单例 - 避免重复从沙盒加载归档文件，提高效率，让 access_token 便于被访问到
    static let sharedUserAccount = UserAccountViewModel()
    
    /// 用户登录标记
    var userLogin: Bool {
        // 1. 如果 token 有值，说明登录成功
        // 2. 如果没有过期，说明登录有效
        return account?.access_token != nil && !isExpired
    }
    
}

// MARK: - 用户账户相关的网络方法
extension UserAccountViewModel {
    
    /// 加载 token
    ///
    /// - parameter code:     授权码
    /// - parameter finished: 完成回调(是否成功)
    func loadAccessToken(code: String, finished: @escaping (_ isSuccessed: Bool)->()) {
        NetworkTools.sharedTools.loadAccessToken(code: code) { (result, error) -> () in
            // 1> 判断错误
            if error != nil {
                print("出错了")
                
                // 失败的回调
                finished(false)
                return
            }
            
            // 2> 输出结果
            // 任何 AnyObject 在使用前，必须使用as ?/! 转换类型
            // 创建账户对象 - 保存在 self.account 属性中
            self.account = UserAccount(dict: result as! [String: AnyObject])
            self.loadUserInfo(account: self.account!, finished: finished)
        }
    }
    
    /// 加载用户信息
    ///
    /// - parameter account: 用户账户对象
    private func loadUserInfo(account: UserAccount, finished: @escaping (_ isSuccessed: Bool)->()) {
        
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!, accessToken: account.access_token!){
            (result, error) in
            if error != nil {
                print("加载用户出错了")
                finished(false)
                return
            }
            
            guard let dict = result as? [String: AnyObject] else {
                print("格式错误")
                finished(false)
                return
            }
            
            // dict 一定是一个有值的字典
            // 将用户信息保存
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            
            // 保存对象 － 会调用对象的 encodeWithCoder 方法
            NSKeyedArchiver.archiveRootObject(account, toFile: self.accountPath)
            print(self.accountPath)
            // 需要完成回调!!!
            finished(true)
        }
    }
    
    /// 返回有效的token
    var accessToken : String? {
        // 如果token没有过期，返回account中的token属性
        if !isExpired {
            return account?.access_token
        }
        return nil
    }
    
    //用户头像URL
    var avatarUrl: NSURL{
        return NSURL(string: account?.avatar_large ?? "")!
    }
    
}
