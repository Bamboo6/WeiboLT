//
//  NewFeatureViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/11/9.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

/// 可重用 CellId
private let WBNewFeatureViewCellId = "WBNewFeatureViewCellId"
/// 新特性图像的数量
private let WBNewFeatureImageCount = 4

class NewFeatureViewController: UICollectionViewController {
    
    init() {
        // super.指定的构造函数
        let layout = UICollectionViewFlowLayout()
        // 设置每个单元格尺寸
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0 //设置行间距为0
        layout.minimumInteritemSpacing = 0 //设置单元格的间距为0
        layout.scrollDirection = .horizontal //设置滚动方向为横向
        // 构造函数，完成之后内部舒心才会被创建
        super.init(collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true // 开启分页
        collectionView?.bounces = false // 去掉弹簧效果
        // 去掉水平方向上的滚动条
        collectionView?.showsHorizontalScrollIndicator = false
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册可重用Cell
        self.collectionView!.register(NewFeatureCell.self,forCellWithReuseIdentifier: WBNewFeatureViewCellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    // 返回每个分组中，单元格的数量
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return WBNewFeatureImageCount
    }
    
    // 返回每个单元格
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
        cell.imageIndex = indexPath.item
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red:UIColor.green
        // Configure the cell
        return cell
    }

}

// 新特性 Cell
private class NewFeatureCell: UICollectionViewCell {
    // frame 的大小是 layout.itemSize 指定的
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 1. 添加控件
        addSubview(iconView)
        // 2. 指定位置
        iconView.frame = bounds
    }
    
    /// 图像属性
    public var imageIndex: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
        }
    }
    
    // MARK: - 懒加载控件
    /// 图像
    private lazy var iconView: UIImageView = UIImageView()
}
