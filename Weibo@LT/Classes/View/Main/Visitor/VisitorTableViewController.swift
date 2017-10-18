//
//  VisitorTableViewController.swift
//  Weibo@LT
//
//  Created by LT on 2017/10/11.
//  Copyright © 2017年 LT. All rights reserved.
//

import UIKit

class VisitorTableViewController: UITableViewController {
    
    ///用户登记标记
    private var userLogon = false
    
    ///访客视图
    var visitorView: VisitorView?
    override func loadView() {
        //根据用户登录情况，决定显示的根视图
        userLogon ? super.loadView():setupVisitorView()
    }
    ///设置访客视图
    private func setupVisitorView(){
        //替换根视图
        visitorView = VisitorView()
        view = visitorView
        
        //添加监听方法
        visitorView?.registerButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewDidRegister), for: UIControlEvents.touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewDidLogin), for: UIControlEvents.touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}

extension VisitorTableViewController{
    func visitorViewDidRegister() {
        print("注册")
    }
    func visitorViewDidLogin() {
        let vc = OAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true,completion: nil)
        
        
    }
}
