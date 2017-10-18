//
//  MainViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/11.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        setupComposedButton()
//        NetworkTools.sharedTools.request(method: HMRequestMethod.GET, URLString: "http://httpbin.org/get", parameters: ["name": "zhangsan" as AnyObject ,"age": 18 as AnyObject]){
//            (result,error)->() in
//            print(result)
//        }
//        NetworkTools.sharedTools.request(method: HMRequestMethod.POST, URLString: "http://httpbin.org/post", parameters: ["name": "zhangsan" as AnyObject ,"age": 18 as AnyObject]){
//            (result,error)->() in
//            print(result)
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public  lazy var composedButton: UIButton = UIButton(
        imageName: "tabbar_compose_icon_add",
        backImageName: "tabbar_compose_button")

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        tabBar.bringSubview(toFront: composedButton)
    }
    
}

extension MainViewController{
    public func addChildViewControllers(){
        tabBar.tintColor=UIColor.orange
        addChildViewController(vc: HomeTableViewController(),title:"首页",imageName:"tabbar_home")
        addChildViewController(vc: MessageTableViewController(),title:"消息",imageName:"tabbar_message_center")
        
        addChildViewController(UIViewController())
        
        addChildViewController(vc: DiscoverTableViewController(),title:"发现",imageName:"tabbar_discover")
        addChildViewController(vc: ProfileTableViewController(),title:"我",imageName:"tabbar_profile")
        
    }
    
    private func addChildViewController(vc:UIViewController,title:String,imageName:String) {
        vc.title=title
        
        vc.tabBarItem.image=UIImage(named:imageName)
        
        let nav=UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
    }
    
    public func setupComposedButton(){
        tabBar.addSubview(composedButton)
        let count = childViewControllers.count
        let w = tabBar.bounds.width/CGFloat(count)-1
        composedButton.frame = CGRect(x: w*2, y: 0, width: w, height: tabBar.bounds.height)
        composedButton.addTarget(self, action: #selector(MainViewController.clickComposedButton), for: .touchUpInside)
    }
    @objc private func clickComposedButton(){
        print("点我")
    }
    
}
