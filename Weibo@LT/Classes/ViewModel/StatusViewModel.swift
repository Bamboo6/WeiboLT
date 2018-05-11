//
//  StatusViewModel.swift
//  Weibo@LT
//
//  Created by LT on 2018/4/20.
//  Copyright © 2018年 LT. All rights reserved.
//

import Foundation
import UIKit

class StatusViewModel
{
    /// 微博的模型
    var status: Status
    init(status:Status)
    {
        self.status=status
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

