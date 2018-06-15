//
//  StatusListViewModel.swift
//  kkk
//
//  Created by apple on 18/4/2.
//  Copyright © 2018年 apple. All rights reserved.
//

import Foundation
import SDWebImage
class StatusListViewModel
{
    ///微博数据数组  上拉／下拉刷新
    lazy var statusList=[StatusViewModel]()//[Status]()
    ///下拉刷新计数
    var pulldownCount:Int?
    //缓存单张图片的方法
    public func cacheSingleImage(dataList:[StatusViewModel],finished:@escaping (_ isSuccessed:Bool)->())
    {
        //创建调度组
        let group=DispatchGroup()
        //缓存数据长度
        var dataLength=0
        
        
        for vm in dataList{
            
            if vm.thumbnailUrls?.count != 1 {
                continue
            }
            let url = vm.thumbnailUrls![0]
            print("要缓存的\(url)")
            //sdwebimage－－下载图像（缓存事自动完成的）
            //入组
            group.enter()
            SDWebImageManager.shared().loadImage(with: url as URL, options: [SDWebImageOptions.retryFailed,SDWebImageOptions.refreshCached], progress: nil, completed: { (image, data1, error, _, _, _) in
                if let img = image , let data = UIImagePNGRepresentation(img){
                    //print(data.count)
                    //累加二进制数据的长度
                    dataLength+=data.count
                }
                
            })
            //出组
            group.leave()
        }
        // 监听调度组完成
        
        group.notify(queue: DispatchQueue.main){
            // print("缓存完成 \(dataLength / 1024) K")
            finished(true)
        }
        
        
    }
    /// 加载微博数据
    /// - parameter isPullup: 是否上拉刷新
    /// - parameter finished: 完成回调
    func loadStatus(isPullup: Bool, finished:@escaping (Bool)->())
    {
        // 下拉刷新 - 数组中第一条微博的id
        let since_id = isPullup ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉刷新 - 数组中最后一条微博的id
        let max_id = isPullup ? (statusList.last?.status.id ?? 0) : 0
        NetworkTools.sharedTools.loadStatus(since_id: since_id,max_id: max_id){
            (result,error)->() in
            if error != nil
            {
                print("出错了")
                finished(false)
                return
            }
            let result1=result as? [String:AnyObject]
            guard let array = result1?["statuses"] as? [[String:AnyObject]] else//判断result的数据结构是否正确
            {
                print("数据格式错误")
                finished(false)
                return
            }
            //遍历字典的数组，字典转模型
            //1 可变的数组
            var dataList = [StatusViewModel]()//[Status]()
            
            for dict in array
            {
                //dataList.append(Status(dict: dict))
                dataList.append(StatusViewModel(status: Status(dict:dict)))
            }
            
            
            // 记录下拉刷新的数据
            self.pulldownCount = (since_id > 0) ? dataList.count : nil
            
            //self.statusList = dataList+self.statusList
            // 3. 拼接数据
            // 判断是否是上拉刷新
            if max_id > 0 {
                self.statusList += dataList
            } else {
                self.statusList = dataList + self.statusList
            }
            
            self.cacheSingleImage(dataList:dataList,finished: finished)
            
            //finished(true)
            
        }
        
    }
    
    
    
}


