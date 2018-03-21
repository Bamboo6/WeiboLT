//
//  WelcomeViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/11/16.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    // MARK: - 视图生命周期
    // 设置界面，视图的层次结构
    override func loadView() {
        //直接使用背景图像作为根视图，不用关心图像的缩放问题
        view = backImageView
        setupUI() // 加载欢迎界面头像、文字
    }
    
    // 视图加载完成之后的后续处理，通常用来设置数据
    override func viewDidLoad() {
        super.viewDidLoad()
        //异步加载用户头像
        iconView.sd_setImage(with: UserAccountViewModel.sharedUserAccount.avatarUrl as URL, placeholderImage: UIImage(named: "avatar_default_big"))
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 懒加载控件
    //背景图片
    private lazy var backImageView: UIImageView = UIImageView(imageName:"ad_background")
    
    //头像
    public lazy var iconView: UIImageView = {
        let iv = UIImageView(imageName:"avatar_default_big")
        //设置圆角
        iv.layer.cornerRadius = 45
        iv.layer.masksToBounds = true
        return iv
    }()
    
    //欢迎Label
    public lazy var welcomeLabel: UILabel = UILabel(title: "欢迎归来", fontSize: 18)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 视图已经显示，通常可以动画／键盘处理
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1.更新约束 –> 改变位置
        // snp_updateContraints更新已经设置过的约束
        iconView.snp.updateConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom)
            .offset(-view.bounds.height + 200)
        }
        
        // 2.动画
        welcomeLabel.alpha = 0
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {
            //自动布局的动画
            self.view.layoutIfNeeded()
        }) { (_) in
            
            UIView.animate(withDuration: 0.8, animations: {
                self.welcomeLabel.alpha = 1
            }, completion: { (_) in
                //发送通知
                NotificationCenter.default.post (name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: nil)
            })
        }
        
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

extension WelcomeViewController{
    public func setupUI(){
        // 1.添加控件
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        // 2.自动布局
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-200)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(16)
        }
    }
}
