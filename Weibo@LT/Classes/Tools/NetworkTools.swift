//
//  NetworkTools.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/12.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    public let appKey = "1249136323"
    public let appSecret = "b18fb6285bb36dc744d9efaa48a251f9"
    public let redirectUrl = "http://www.baidu.com"
    
//    typealias HMRequestCallBack = (Any?,URLSessionTask?)->()
    typealias HMRequestCallBack = (Any?,Error?)->()
    
    //单例
    static let sharedTools: NetworkTools = {
        let tools = NetworkTools(baseURL: nil)
        // 设置反序列化数据格式 - 系统会自动将 OC 框架中的 NSSet 转换成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    
}

extension NetworkTools{
    func request(method:HMRequestMethod, URLString:String,parameters:[String: AnyObject]?,finished:@escaping HMRequestCallBack){
        /*let success = {(task:URLSessionTask?,result:Any?)->()
            in finished(result,task)}*/
        let success={(task:URLSessionDataTask?,result:Any?)->()
            in finished(result,nil)}
        /*let failure = {(task:URLSessionTask?,error:Error?)->()
            in finished(error,task)}*/
        let failure={(task:URLSessionDataTask?,error:Error?)->()
            in finished(nil,error)}
        
        if method == HMRequestMethod.GET{
            get(URLString, parameters: parameters,progress: nil, success: success,failure: failure)
        }
        if method == HMRequestMethod.POST{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    //加载用户信息
    func loadUserInfo(uid: String, accessToken:String,finished:@escaping HMRequestCallBack) {
        // 1. 获取token字典
        guard var params=tokenDict else {
            //如果字典为nil，通知调用方token无效
            finished(nil,NSError(domain:"cn.itcast.error",code:-1001,userInfo:["message":"token为空"]))
            return
        }
        // 2. 处理网络参数
        let urlString = "https://api.weibo.com/2/users/show.json"
//        let params:[String:AnyObject]?=["uid": uid as AnyObject,"access_token":accessToken as AnyObject]
        params["uid"]=uid as AnyObject?
//        request(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]?, finished: finished)
        request(method: .GET, URLString: urlString, parameters: params, finished: finished)
    }
    //返回token字典
    public var tokenDict:[String:AnyObject]?{
        //如果token没有过期，返回account中的token属性
        if let token=UserAccountViewModel.sharedUserAccount.account?.access_token{
            return ["access_token":token as AnyObject]
        }
        return nil
    }
    
}

extension NetworkTools{
    // MARK: - OAuth 相关方法
    /// OAuth 授权 URL
    var OAuthURL: NSURL {
//        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_url=\(redirectUrl)"
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return NSURL(string: urlString)!
    }
    
    /// 加载 AccessToken
    func loadAccessToken(code: String, finished: @escaping HMRequestCallBack) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params:[String:AnyObject]?=["client_id": appKey as AnyObject,
                                        "client_secret": appSecret as AnyObject,
                                        "grant_type": "authorization_code" as AnyObject,
                                        "code": code as AnyObject,
                                        "redirect_uri": redirectUrl as AnyObject]
        request(method: .POST, URLString: urlString, parameters: params, finished: finished)
        
//        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject], finished: finished)
        
/*        /// 测试返回的数据内容
                // 1> 设置相应数据格式是二进制的
                responseSerializer = AFHTTPResponseSerializer()
        
                // 2> 发起网络请求
        post(urlString, parameters: params, success: { (_, result) -> Void in
                // 将二进制数据转换成字符串
            let json = NSString(data: (result as! NSData) as Data, encoding:String.Encoding.utf8.rawValue)
                    print(json)
                }, failure: nil)*/
    }
 
    
}

//HTTP请求方法枚举
enum HMRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}
