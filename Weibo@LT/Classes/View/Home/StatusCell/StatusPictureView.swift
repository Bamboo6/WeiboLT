//
//  StatusPictureView.swift
//  Weibo@LT
//
//  Created by LT on 2018/5/16.
//  Copyright © 2018年 LT. All rights reserved.
//

import UIKit

import SDWebImage

/// 照片之间的间距
public let StatusPictureViewItemMargin: CGFloat = 8

/// 可重用表示符号
public let StatusPictureCellId = "StatusPictureCellId"

class StatusPictureView: UICollectionView {
    
    /// 微博视图模型
    var viewModel: StatusViewModel? {
        didSet {
            sizeToFit()
            reloadData()
        }
    }
    
    // MARK: - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        // 设置间距 － 默认 itemSize 50 * 50
        layout.minimumInteritemSpacing = StatusPictureViewItemMargin
        layout.minimumLineSpacing = StatusPictureViewItemMargin
        
        // 设置数据源 - 自己当自己的数据源
        // 应用场景：自定义视图的小框架
        dataSource = self
        
        //注册可重用的cell
        register(StatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureCellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return calcViewSize()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// MARK: - 计算视图大小
extension StatusPictureView {
    /// 计算视图大小
    public func calcViewSize() -> CGSize {
        // 1. 准备
        // 每行的照片数量
        let rowCount: CGFloat = 3
        // 最大宽度
        let maxWidth = UIScreen.main.bounds.width - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * StatusPictureViewItemMargin) / rowCount
        
        // 2. 设置 layout 的 itemSize
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        // 3. 获取图片数量
        let count = viewModel?.thumbnailUrls?.count ?? 0
        
        // 计算开始
        // 1> 没有图片
        if count == 0 {
            return CGSize.zero
        }
        
        // 2> 一张图片
        if count == 1 {
            // 临时设置单图大小
            var size = CGSize(width: 150, height: 120)
            
//            // 提取单图
//            if let key = viewModel?.thumbnailUrls?.first?.absoluteString {
//                if let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key) {
//                    size = image.size
//                }
//            }

            // 图像过窄处理
            size.width = size.width < 40 ? 40 : size.width
            
            // 图像过宽处理，等比例缩放
            if size.width > 300 {
                let w: CGFloat = 300
                let h = size.height * w / size.width
                size = CGSize(width: w, height: h)
            }
            
            // 内部图片的大小
            layout.itemSize = size
            
            // 配图视图的大小
            return size
        }
        
        // 3> 四张图片 2 * 2 的大小
        if count == 4 {
            let w = 2 * itemWidth + StatusPictureViewItemMargin
            return CGSize(width: w, height: w)
        }
        
        // 4> 其他图片 按照九宫格来显示
        // 计算出行数
        let row = CGFloat((count - 1) / Int(rowCount) + 1)
        let h = row * itemWidth + (row - 1) * StatusPictureViewItemMargin + 1
        let w = rowCount * itemWidth + (rowCount - 1) * StatusPictureViewItemMargin  + 1
        return CGSize(width: w, height: h)
    }
}

// MARK: - UICollectionViewDataSource
extension StatusPictureView: UICollectionViewDataSource {
    //返回thumbnailUrls个数，就是图片的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    
    //设置格子的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureCellId, for: indexPath) as! StatusPictureViewCell
        //cell.backgroundColor=UIColor.red
        cell.imageURL = viewModel!.thumbnailUrls![indexPath.item]
        return cell
    }
}


///  MARK: - 配图 cell
class StatusPictureViewCell: UICollectionViewCell {
    
    /// GIF 提示图片
    public lazy var gifIconView:UIImageView=UIImageView(imageName:"timeline_image_gif")
    
    public lazy var iconView:UIImageView = {//UIImageView()
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill// 完全填充模式
        iv.clipsToBounds=true//局限于试图边界
        return iv
    }()
    
    var imageURL:NSURL? {
        didSet {
            iconView.sd_setImage(with:imageURL as URL?,
                                 placeholderImage: nil, // 在调用 OC 的框架时，可/必选项不严格
                options: [SDWebImageOptions.retryFailed,// SD超时时长 15s，一旦超时会记入黑名单。
                          SDWebImageOptions.refreshCached])// 如果 URL 不变，图像变
                            // 重试，刷新缓存
            // 根据文件的扩展名判断是否是 GIF，但是不是所有的 GIF 都会动
            let ext = ((imageURL?.absoluteString ?? "") as NSString).pathExtension.lowercased()
            gifIconView.isHidden = (ext != "gif")
        }
    }
    
    /// MARK: - 构造函数
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI() {
        // 1. 添加控件
        contentView.addSubview(iconView)
        // 2. 设置布局 - 提示因为 cell 会变化，另外，不同的 cell 大小可能不一样
        iconView.addSubview(gifIconView)
        iconView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(contentView.snp.edges)
        }
        // 添加GIF图标，设置自动布局
        gifIconView.snp.makeConstraints{
            (make)->Void in
            make.right.equalTo(iconView.snp.right)
            make.bottom.equalTo(iconView.snp.bottom)
            
        }
    }
}
