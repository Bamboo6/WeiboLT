//
//  VisitorView.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/11.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
        
    }
    //initWithCoder - 使用StoryBoard & XIB 开发加载的函数
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupUI()
        fatalError("init(coder:) has not bee implemented")
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //mark:－懒加载控件
    ///图标，使用image:构造函数创建的imgaeView默认就是image的大小
    public  lazy var iconView:UIImageView = UIImageView(image:UIImage(named:"visitordiscover_feed_image_smallicon"))
    //小房子
    public lazy var homeIconView:UIImageView=UIImageView(image:UIImage(named:"visitordiscover_feed_image_house"))
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "关注一些人，回这里看看有什么惊喜"
        //界面设计上，避免使用纯黑色
        //设置Label文字颜色
        label.textColor = UIColor.darkGray
        //设置Label字体大小
        label.font = UIFont.systemFont(ofSize: 14)
        //设置label文字不限制行数
        label.numberOfLines = 0
        //设置文字的对齐方式
        label.textAlignment = NSTextAlignment.center
        return label
        
    }()
    //遮罩图像
    public lazy var maskIconView: UIImageView = UIImageView(image:UIImage(named:"visitordicover_feed_mask_smallicon"))
    
    
    
    
    //注册按钮
    public lazy var registerButton: UIButton = {
        let button = UIButton()
        //设置普通状态下按钮文字
        button.setTitle("注册", for: UIControlState.normal)
        //设置普通状态下按钮文字颜色
        button.setTitleColor(UIColor.orange, for: UIControlState.normal)
        //设置普通状态下按钮背景图片
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState.normal)
        return button
    }()
    //登录按钮
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        //设置普通状态下按钮文字
        button.setTitle("登录", for: UIControlState.normal)
        //设置普通状态下按钮文字颜色
        button.setTitleColor(UIColor.orange, for: UIControlState.normal)
        //设置普通状态下按钮背景图片
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState.normal)
        return button
    }()
    
}
extension VisitorView{
    // 设置界面
    public func setupUI(){
        addSubview(iconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        addSubview(maskIconView)
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //1>图标
        addConstraint(NSLayoutConstraint(item:iconView, attribute: .centerX, relatedBy: .equal, toItem: self,attribute: .centerX, multiplier: 1.0, constant:0))
        addConstraint(NSLayoutConstraint(item:iconView, attribute: .centerY, relatedBy: .equal, toItem: self,attribute: .centerY, multiplier: 1.0, constant:0))
        //2>小房子
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: self,attribute: .centerX, multiplier: 1.0, constant:0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: self,attribute: .centerY, multiplier: 1.0, constant:0))
        //3>消息文字
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView,attribute: .centerX, multiplier: 1.0, constant:0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView,attribute: .bottom, multiplier: 1.0, constant:16))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant:224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant:36))
        //4注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier:1.0,constant:0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier:1.0,constant:16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier:1.0,constant:100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier:1.0,constant:36))
        //5登录按钮
        addConstraint(NSLayoutConstraint(item:loginButton, attribute: .right, relatedBy: .equal, toItem:messageLabel, attribute: .right, multiplier: 1.0, constant:0))
        addConstraint(NSLayoutConstraint(item:loginButton, attribute: .top, relatedBy: .equal, toItem:messageLabel, attribute: .bottom, multiplier: 1.0, constant:16))
        addConstraint(NSLayoutConstraint(item:loginButton, attribute: .width, relatedBy: .equal, toItem:nil, attribute: .notAnAttribute, multiplier: 1.0, constant:100))
        addConstraint(NSLayoutConstraint(item:loginButton, attribute: .height, relatedBy: .equal, toItem:nil, attribute: .notAnAttribute, multiplier: 1.0, constant:36))
        //遮罩图像
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: ("H:|-0-[mask]-0-|"), options: [], metrics: nil, views: ["mask":maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight":-36], views: ["mask":maskIconView,"regButton":registerButton]))
        backgroundColor = UIColor(white:237.0 / 255.0, alpha:1.0)
    }
    func setupInfo(imageName: String?, title:String){
        //设置消息label的文字
        messageLabel.text = title
        //如果图片名称为nil，说明是首页，直接返回
        guard let imgName = imageName else{
            startAnim()
            return
        }
        //隐藏小房子
        homeIconView.isHidden = true
        //将遮罩图像移动到底层
        sendSubview(toBack: maskIconView)
        iconView.image = UIImage(named: imgName)
    }
    //开启首页轮转动画
    private func startAnim(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.isRemovedOnCompletion = false
        //添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
}
