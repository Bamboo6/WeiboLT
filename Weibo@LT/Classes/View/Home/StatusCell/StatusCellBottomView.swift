//
//  StatusCellBottomView.swift
//  Weibo@LT
//
//  Created by LT on 2018/4/25.
//  Copyright © 2018年 LT. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    /// 转发按钮
    public lazy var retweetedButton: UIButton = UIButton(title: " 转发", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_retweet")
    
    /// 评论按钮
    public lazy var commentButton: UIButton = UIButton(title: " 评论", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_comment")
    
    /// 点赞按钮
    public lazy var likeButton: UIButton = UIButton(title: " 赞", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_unlike")
    
}

// MARK: - 设置界面
extension StatusCellBottomView {
    public func setupUI() {
        // 0. 设置背景颜色
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        // 1. 添加控件
        addSubview(retweetedButton)
        addSubview(commentButton)
        addSubview(likeButton)
        
        // 2. 自动布局
        retweetedButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        commentButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedButton.snp.top)
            make.left.equalTo(retweetedButton.snp.right)
            make.width.equalTo(retweetedButton.snp.width)
            make.height.equalTo(retweetedButton.snp.height)
        }
        
        likeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(commentButton.snp.top)
            make.left.equalTo(commentButton.snp.right)
            make.width.equalTo(commentButton.snp.width)
            make.height.equalTo(commentButton.snp.height)
            make.right.equalTo(self.snp.right)
        }
        
        // 3. 分隔视图
        let sep1 = sepView()
        let sep2 = sepView()
        addSubview(sep1)
        addSubview(sep2)
        
        // 布局
        let w = 1
        let scale = 0.4
        sep1.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(retweetedButton.snp.right)
            make.centerY.equalTo(retweetedButton.snp.centerY)
            make.width.equalTo(w)
            make.height.equalTo(retweetedButton.snp.height)
                .multipliedBy(scale)
        }
        
        sep2.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(commentButton.snp.right)
            make.centerY.equalTo(retweetedButton.snp.centerY)
            make.width.equalTo(w)
            make.height.equalTo(retweetedButton.snp.height)
                .multipliedBy(scale)
        }
        
    }
    
    /// 创建分隔视图
    private func sepView() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
