//
//  StatusRetweetedCell.swift
//  Weibo@LT
//
//  Created by LT on 2018/5/23.
//  Copyright © 2018年 LT. All rights reserved.
//

import UIKit

class StatusRetweetedCell: StatusCell {
    
    // MARK: - 懒加载控件
    /// 背景图片
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        return button
    }()
    /// 转发微博标签
    public lazy var retweetedLabel: UILabel = UILabel(
        title: "转发微博",
        fontSize: 14,
        color: UIColor.darkGray,
        screenInset: StatusCellMargin)
    
    /// 微博视图模型
    override var viewModel: StatusViewModel? {
        didSet {
            // 转发微博的文字
            retweetedLabel.text = viewModel?.retweetedText
            // 修改配图视图顶部位置
            pictureView.snp.updateConstraints { (make) -> Void in
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(retweetedLabel.snp.bottom).offset(offset)
            }
        }
    }

}

// MARK: - 设置界面
extension StatusRetweetedCell {
    
    /// 设置界面
    override func setupUI() {
        // 调用父类的 setupUI，设置父类控件位置
        super.setupUI()
        
        // 1. 添加控件
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        
        //2. 自动布局
        backButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        retweetedLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(backButton.snp.top).offset(StatusCellMargin)
            make.left.equalTo(backButton.snp.left).offset(StatusCellMargin)
        }
        
        // 配图视图
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetedLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
    
}

