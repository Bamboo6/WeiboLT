//
//  StatusNormalCell.swift
//  Weibo@LT
//
//  Created by LT on 2018/6/1.
//  Copyright © 2018年 LT. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusCell {

    override var viewModel: StatusViewModel? {
        didSet {
            // 修改配图视图大小
            pictureView.snp.updateConstraints { (make) -> Void in
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        // 3> 配图视图
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }

}
