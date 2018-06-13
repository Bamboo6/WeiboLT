//
//  StatusViewModel.swift
//  Weibo@LT
//
//  Created by LT on 2018/4/20.
//  Copyright © 2018年 LT. All rights reserved.
//

import Foundation
import UIKit

class StatusViewModel: CustomStringConvertible {
    /// 可重用标识符
    var cellId: String {
        return status.retweeted_status != nil ? StatusCellRetweetedId: StatusCellNormalId
    }
    
    /// 被转发原创微博的文字
    var retweetedText: String? {
        guard let s = status.retweeted_status else {
            return nil
        }
        return "@" + (s.user?.screen_name ?? "") + ":" + (s.text ?? "")
    }
    
    /// 行高
    lazy var rowHeight: CGFloat = {
        // print("计算缓存行高 \(self.status.text)")
        var cell: StatusCell
        
        // 实例化 cell
        if self.status.retweeted_status != nil {
            cell = StatusRetweetedCell(style: .default, reuseIdentifier:StatusCellRetweetedId)
        } else {
            cell = StatusNormalCell(style: .default, reuseIdentifier:StatusCellNormalId)
        }
        
        // 实例化 cell
//        let cell = StatusCell(style: .default, reuseIdentifier: StatusCellNormalId)
//        let cell = StatusRetweetedCell(style: .default, reuseIdentifier: StatusCellRetweetedId)
           
        // 返回行高
        return cell.rowHeight(vm: self)
    }()
    
    /// 缩略图URL数组 - 存储型属性 !!!
    var thumbnailUrls: [NSURL]?
    
    /// 描述信息
    var description: String {
        return status.description + "配图数组 \(thumbnailUrls ?? ([] as NSArray) as! [NSURL])"
        //        return status.description
    }
    
    /// 微博的模型
    var status: Status
    
    init(status:Status){
        self.status = status
        
        // 根据模型，来生成缩略图的数组
        if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls  {
            // 创建缩略图数组
            thumbnailUrls = [NSURL]()
            // 遍历字典数组 - 数组如果是可选的，不允许遍历，原因：数组是通过下标来检索数据
            for dict in urls {
                // 因为字典是按照 key 来取值，如果 key 错误，会返回 nil
                let url = NSURL(string: dict["thumbnail_pic"]!)
                // 相信服务器返回的 url 字符串一定能够生成
                thumbnailUrls?.append(url!)
            }
        }
    }
    
    /// 用户头像 URL
    var userProfileUrl: NSURL {
        return NSURL(string: status.user?.profile_image_url ?? "")!
        //空合并运算符  (a ?? b) 将对可选类型a进行空判断，如果a包含一个值就进行解封，否则就返回一个默认值b。两个条件：表达式a必须是可选类型，默认值b的类型必须要和a存储值的类型一致
    }
    
    /// 用户默认头像
    var userDefaultIconView: UIImage {
        return UIImage(named: "avatar_default_big")!
    }
    
    /// 用户会员图标
    var userMemberImage: UIImage? {
        // 根据 mbrank 来生成图像
        if (status.user?.mbrank)! > 0 && (status.user?.mbrank)! < 7 {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    /// 用户认证图标
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var userVipImage: UIImage? {
        switch(status.user?.verified_type ?? -1) {
        case 0: return UIImage(named: "avatar_vip")
        case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default: return nil
        }
    }
    
}




