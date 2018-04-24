//
//  StatusListViewModel.swift
//  Weibo@LT
//
//  Created by LT on 2018/4/18.
//  Copyright © 2018年 LT. All rights reserved.
//

import Foundation

/// 微博数据列表模型 － 封装网络方法
class StatusListViewModel{
    /// 微博数据数组 - 上拉/下拉刷新
    lazy var statusList = [StatusViewModel]()
    /// 加载微博数据
    /// - parameter isPullup: 是否上拉刷新
    /// - parameter finished: 完成回调
    func loadStatus(finished: @escaping (Bool)->()) {
        NetworkTools.sharedTools.loadStatus { (result, error) -> () in
            if error != nil {
                print("出错了")
                finished(false)
                return
            }
//            print(result)
            
            // 判断 result 的数据结构是否正确
            guard let array = (result as AnyObject)["statuses"] as? [[String: AnyObject]]
                else {
                    print("数据格式错误")
                    finished(false)
                    return
                    }
            
            // 遍历字典的数组，字典转模型
            // 1. 可变的数组
            var dataList = [StatusViewModel]()
            // 2. 遍历数组
            for dict in array {
//                dataList.append(Status(dict: dict))
                dataList.append(StatusViewModel(status: Status(dict:dict)))
            }
            // 3. 拼接数据
            self.statusList = dataList + self.statusList
            // 完成回调
            finished(true)
        }
        
            }
        
        
}
