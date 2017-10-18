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
    
    public let appkey = "1249136323"
    public let appScret = "b18fb6285bb36dc744d9efaa48a251f9"
    public let redirectUrl = "http://www.baidu.com"
    
    static let sharedTools: NetworkTools = {
        let tools = NetworkTools(baseURL:nil)
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
    typealias HMRequestCallBack = (Any?,URLSessionTask?)->()
}

extension NetworkTools{
    func request(method:HMRequestMethod, URLString:String,parameters:[String: AnyObject]?,finished:@escaping HMRequestCallBack){
        let success = {(task:URLSessionTask?,result:Any?)->()
            in finished(result,nil)}
        let failure = {(task:URLSessionTask?,error:Error?)->()
            in finished(error,nil)}
        if method == HMRequestMethod.GET{
            get(URLString, parameters: parameters,progress: nil, success: success,failure: failure)
        }
        if method == HMRequestMethod.POST{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
    
}

extension NetworkTools{
    // MARK: - OAuth 相关方法
    /// OAuth 授权 URL
    var OAuthURL: NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appkey)&redirect_url=\(redirectUrl)"
        return NSURL(string: urlString)!
    }
}

//HTTP请求方法枚举
enum HMRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}
