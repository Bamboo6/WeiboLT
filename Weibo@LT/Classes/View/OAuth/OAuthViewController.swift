//
//  OAuthViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/18.
//  Copyright © 2017年 LT. All rights reserved.
//
//test12

import UIKit

class OAuthViewController: UIViewController {
    private lazy var webView = UIWebView()
    // MARK: - 监听方法
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    /// 自动填充用户名和密码 － web 注入（以代码的方式向web页面添加内容）
    @objc private func autoFill() {
        let js = "document.getElementById('userId').value = 'dream1718@foxmail.com';" + "document.getElementById('passwd').value = '***';"
        // 让 webView 执行 js
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    override func loadView() {
        view = webView
        
        //设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭",style: .plain, target: self, action:#selector(OAuthViewController.close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(OAuthViewController.autoFill))
        
        /// 设置代理
        webView.delegate = self as! UIWebViewDelegate
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.loadRequest(NSURLRequest(url:NetworkTools.sharedTools.OAuthURL as URL) as URLRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate {
    
    /// 将要加载请求的代理方法
    /// - parameter webView:        webView
    /// - parameter request:        将要加载的请求
    /// - parameter navigationType: 页面跳转的方式
    /// - returns: 返回 false 不加载，返回 true 继续加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request:
        URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 目标：如果是百度，就不加载
        // 1. 判断访问的主机是否是 www.baidu.com
        guard let url = request.url, url.host == "www.baidu.com" else {
            print("是www.baidu.com")
            return true
        }
        
        // 2. 从百度地址的 url 中提取 `code=` 是否存在
        guard let query = url.query, query.hasPrefix("code=") else {
            print("取消授权")
            return false
        }
        
        // 3. 从 query 字符串中提取 `code=` 后面的授权码
//        let code = query.substring(from:"code=".endIndex)
        let code = query.substring(from: "code=".endIndex)
        print("授权码是 " + code)
        
        /*// 加载accessToken
        NetworkTools.sharedTools.loadAccessToken(code: code) {
            (result,error) in
            // 1>判断错误
            if error?.error != nil {
                print("出错了")
                return
            }
            // 2>输出结果
            print(result!)
            let test=result as! [String:Any]
            //print(test["uid"])
            let account = UserAccount(dict: result as! [String:AnyObject])
            self.loadUserInfo(account: account)
            
        }*/
        
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code){
            (isSuccessed)->() in
            if isSuccessed {
                print("成功了")
                print(UserAccountViewModel.sharedUserAccount.account)
                //用户登录成功，则退出当前控制器，并发送切换根控制器的通知
                self.dismiss(animated: false) {
                    NotificationCenter.default.post (name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: "welcome")
                }
            } else {
                print("失败了")
            }
        }
        
        return false
        
    }
    /*private func loadUserInfo(account: UserAccount) {
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!, accessToken: account.access_token!){
            (result,error) in
            if error?.error != nil {
                print("加载用户出错了")
                return
            }
                //作了两个判断 1.result一定有内容 2.一定是字典
                guard let dict = result as? [String:AnyObject] else {
                    print("格式错误")
                    return
                }
            
                //dict一定是一个有值的字典
                /*print(dict["screen_name"])
                print(dict["avatar_large"])*/
                account.screen_name = dict["screen_name"] as? String
                account.avatar_large = dict["avatar_large"] as? String
                print(account)
            
        }
    }*/
}

