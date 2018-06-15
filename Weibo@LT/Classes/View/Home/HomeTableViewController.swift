//
//  HomeTableViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/11.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 原创微博 Cell 的可重用表示符号
let StatusCellNormalId = "StatusCellNormalId"

/// 转发微博 Cell 的可重用标识符号
let StatusCellRetweetedId = "StatusCellRetweetedId"

class HomeTableViewController: VisitorTableViewController {
    
    /// 微博数据数组
//    var dataList: [Status]?
    
    public lazy var listViewModel=StatusListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //判断是否登陆
        if !UserAccountViewModel.sharedUserAccount.userLogin{
            visitorView?.setupInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        loadData()
        prepareTableView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view dataource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return 0
        return listViewModel.statusList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
//        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath) as! StatusCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellRetweetedId, for: indexPath) as! StatusCell
                // 测试微博信息内容
        //        cell.textLabel?.text = dataList![indexPath.row].text
//                cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
//        cell.textLabel?.text=listViewModel.statusList[indexPath.row].status.user?.screen_name
//        cell.viewModel = listViewModel.statusList[indexPath.row]
        
        // 1.获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        // 2.获取可重用 cell 会调用行高方法！
        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellId, for: indexPath) as! StatusCell
        
        // 3.设置视图模型
        cell.viewModel = vm
        
        // 4. 判断是否是最后一条微博
        if indexPath.row == listViewModel.statusList.count - 1 && !pullupView.isAnimating {
            // 开始动画
            pullupView.startAnimating()
            // 上拉刷新数据
            loadData()
        }
        
        return cell
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// 加载数据
    @objc
    public func loadData() {
        refreshControl?.beginRefreshing()
        // 关闭刷新控件
//        self.refreshControl?.endRefreshing()
        //        NetworkTools.sharedTools.loadStatus { (result, error) -> () in
        //            if error != nil {
        //                print("出错了")
        //                return
        //            }
        //            print(result)
        //
        //        }
        //        // 判断 result 的数据结构是否正确
        //        guard let array = result?["statuses"] as? [[String: AnyObject]]
        //            else {
        //                print("数据格式错误")
        //                return
        //        }
        //        print(array)
        //
        //        // 遍历字典的数组，字典转模型
        //        // 1. 可变的数组
        //        var dataList = [Status]()
        //        // 2. 遍历数组
        //        for dict in array {
        //            dataList.append(Status(dict: dict))
        //        }
        //        // 3. 测试
        //        print(dataList)
        //        self.dataList = dataList
        //        // 刷新数据
        //        self.tableView.reloadData()
        
        listViewModel.loadStatus(isPullup: pullupView.isAnimating){ (isSuccessed)->() in
            // 关闭刷新控件
            self.refreshControl?.endRefreshing()
            // 关闭上拉刷新
            self.pullupView.stopAnimating()
            
            if !isSuccessed {
                SVProgressHUD.showInfo(withStatus: "加载数据错误，请稍后再试")
                return
            }
            print(self.listViewModel.statusList)
            // 显示下拉刷新提示
            self.showPulldownTip()
            // 刷新数据
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - 懒加载控件
    /// 上拉刷新提示视图
    private lazy var pullupView: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.color = UIColor.lightGray
        
        return indicator
    }()
    
    /// 下拉刷新提示标签
    private lazy var pulldownTipLabel: UILabel = {
        
        let label = UILabel(title: "", fontSize: 18, color: UIColor.white)
        label.backgroundColor = UIColor.orange
        
        // 添加到 navigationBar
        self.navigationController?.navigationBar.insertSubview(label, at: 0)
        
        return label
    }()
    
    /// 显示下拉刷新
    private func showPulldownTip() {
        
        // 如果不是下拉刷新直接返回
        guard let count = listViewModel.pulldownCount else {
            return
        }
        
        pulldownTipLabel.text = (count == 0) ? "没有新微博" : "刷新到 \(count) 条微博"
        
        let height: CGFloat = 44
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
        pulldownTipLabel.frame =  rect.offsetBy(dx: 0, dy: -2 * height)
        
        UIView.animate(withDuration: 1.0, animations: {
            () -> Void in
            self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: height)
        }) { (_) -> Void in
            UIView.animate(withDuration: 1.0) {
                self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
            }
        }
    }
    
    /// 准备表格
    public func prepareTableView() {
        tableView.register(StatusNormalCell.self, forCellReuseIdentifier: StatusCellNormalId)
        tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedId)
        // 注册可重用 cell
//        tableView.register(StatusCell.self,forCellReuseIdentifier: StatusCellNormalId)
        // 测试行高
//        tableView.rowHeight = 200
        // 取消分割线
        tableView.separatorStyle = .none
        // 自动计算行高 - 需要一个自上而下的自动布局的控件，指定一个向下的约束
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = 400 //UITableViewAutomaticDimension
        // 下拉刷新控件默认没有 - 高度 60
        refreshControl = WBRefreshControl()
        // 添加监听方法
        refreshControl?.addTarget(self, action: #selector(HomeTableViewController.loadData), for:UIControlEvents.valueChanged)
        
        // 注册可重用 cell
//        tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedId)
        tableView.register(StatusNormalCell.self, forCellReuseIdentifier: StatusCellNormalId)
        
        // 上拉刷新视图
        tableView.tableFooterView = pullupView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeTableViewController{
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return dataList?.count ?? 0
//        return listViewModel.statusList.count
//    }
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, forIndexPath: indexPath) as! StatusCell
//        // 测试微博信息内容
////        cell.textLabel?.text = dataList![indexPath.row].text
//        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
//        return cell
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // 1. 获得模型
//        let vm=listViewModel.statusList[indexPath.row]
//        // 2. 实例化 cell
//        let cell=StatusCell(style: .default, reuseIdentifier: StatusCellNormalId)
//        // 3. 获得模型
//        return cell.rowHeight(vm: vm)
        return listViewModel.statusList[indexPath.row].rowHeight
    }
}
