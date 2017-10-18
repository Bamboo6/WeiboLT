//
//  OAuthViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/18.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {
    private lazy var webView = UIWebView()
    // MARK: - 监听方法
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    /// 自动填充用户名和密码 － web 注入（以代码的方式向web页面添加内容）
    @objc private func autoFill() {
        let js = "document.getElementById('userId').value = '291610311@qq.com';" + "document.getElementById('passwd').value = 'W2080999%';"
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
    func webView(webView: UIWebView, shouldStartLoadWithRequest request:
        NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 目标：如果是百度，就不加载
        // 1. 判断访问的主机是否是 www.baidu.com
        guard let url = request.url, url.host == "http://www.baidu.com" else {
            print("是www.baidu.com")
            return true
        }
        
        // 2. 从百度地址的 url 中提取 `code=` 是否存在
        guard let query = url.query, query.hasPrefix("code=") else {
            print("取消授权")
            return false
        }
        
        // 3. 从 query 字符串中提取 `code=` 后面的授权码
        let code = query.substring(from:"code=".endIndex)
        print("授权码是 " + code)
        return false
    }
}

