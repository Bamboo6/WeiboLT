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
    
    override func loadView() {
        view = webView
        //设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭",style: .plain, target: self, action:#selector(OAuthViewController.close))
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
