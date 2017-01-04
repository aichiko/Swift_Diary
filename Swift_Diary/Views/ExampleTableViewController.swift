//
//  ExampleTableViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/24.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol Decodable {
    /// 返回一个model
    func parse(data: Data) -> Self?
}

protocol Client {
    var host: String { get }
    func send<T: CCRequest>(_ r: T, handler: @escaping([T.Response?], Error?) -> Void)
    func alamofireSend<T: CCRequest>(_ r: T, handler: @escaping([T.Response?], Error?) -> Void)
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

protocol CCRequest {
    var path: String { get }
    
    var method: HTTPMethod { get }
    var parameter: [String: Any] { get }
    associatedtype Response: Decodable
    
    /// 返回一个model数组，适用于列表显示
    func parse(data: Data) -> [Response?]?
    
    /// 使用SwiftyJSON 进行解析 返回一个model数组，适用于列表显示
    func JSONParse(jsonData: JSON) -> [Response?]?
}

class ExampleTableViewController: UITableViewController {

    lazy var dataArray = Array<StudyPlanModel?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //使用原生的请求
        let request = StudyPlanModelRequest(parameter: ["userName": "yubin"])
//        URLSessionClient().send(request) { (models, error) in
//            DispatchQueue.main.async {
//                self.dataArray = models
//                self.tableView?.reloadData()
//            }
//        }
        
        //使用Alamofire的请求
        URLSessionClient().alamofireSend(request) { (models, error) in
            DispatchQueue.main.async {
                self.dataArray = models
                self.tableView?.reloadData()
            }
        }
        
        if #available(iOS 10.0, *) {
            // 创建UIRefreshControl
            let refreshControl = UIRefreshControl()
            tableView?.refreshControl = refreshControl
            tableView?.refreshControl?.attributedTitle = NSAttributedString.init(string: "下拉刷新")
            tableView?.refreshControl?.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        } else {
            // Fallback on earlier versions
        }
    }

    @objc private func refreshControlAction(_ refreshControl: UIRefreshControl) {
        NSLog("下拉刷新！！！")
        self.dataArray.removeAll()
        let request = StudyPlanModelRequest(parameter: ["userName": "yubin"])
        URLSessionClient().send(request) { (models, error) in
            DispatchQueue.main.async {
                self.dataArray = models
                self.tableView?.reloadData()
                guard #available(iOS 10.0, *) else{
                    return
                }
                if (self.tableView?.refreshControl?.isRefreshing)! {
                    self.tableView?.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
        // Configure the cell...
        let model = self.dataArray[indexPath.row]
        cell?.textLabel?.text = model?.planName
        cell?.detailTextLabel?.text = "开放时间:\((model?.startTime)!)-\((model?.endTime)!)"
        return cell!
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

}
