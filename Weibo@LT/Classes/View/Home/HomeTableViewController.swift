//
//  HomeTableViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/11.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeTableViewController: VisitorTableViewController {
    
    /// 微博数据数组
//    var dataList: [Status]?
    
    private let StatusCellNormalId = "StatusCellNormalId"//微博cell（表格单元）的可重用表示符
    
    private lazy var listViewModel=StatusListViewModel()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath)
                // 测试微博信息内容
        //        cell.textLabel?.text = dataList![indexPath.row].text
//                cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        cell.textLabel?.text=listViewModel.statusList[indexPath.row].status.user?.screen_name

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
    public func loadData() {
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
        
        listViewModel.loadStatus{ (isSuccessed)->() in
            if !isSuccessed {
                SVProgressHUD.showInfo(withStatus: "加载数据错误，请稍后再试")
                return
            }
            print(self.listViewModel.statusList)
            // 刷新数据
            self.tableView.reloadData()
        }
        
    }
    
    /// 准备表格
    public func prepareTableView() {
        // 注册可重用 cell
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: StatusCellNormalId)
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
}
