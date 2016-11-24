//
//  AFNetViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/16.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit
import Alamofire

class NetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "NetWorking_demo"
        // Do any additional setup after loading the view.
        
        let parameters = ["key":333]
        getNetRequest(parameters: parameters)
    }

    /// get 请求
    private func getNetRequest(parameters: Parameters) {
        Alamofire.request("http://meetliveapi.24hmb.com/api/GetBanner", parameters: parameters).responseString(completionHandler: { (responseString) in
            //debugPrint("responseString Info : \(responseString)")
        }) .responseJSON { (response) in
            debugPrint(response.request!)  // original URL request
            debugPrint(response.response!) // HTTP URL response
            debugPrint(response.data!)     // server data
            debugPrint(response.result)   // result of response serialization
            
            //debugPrint("All Response Info: \(response)")
            
            if let JSON = response.result.value {
                debugPrint("JSON: \(JSON)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                debugPrint("Data: \(utf8Text)")
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
