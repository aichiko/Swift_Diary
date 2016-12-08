//
//  DocumentWebViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/12/8.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit
import WebKit

/// 文档预览页面
class DocumentWebViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    var requestURL: URL? = nil
    
    lazy var webView: WKWebView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        debugPrint("requestURL === \(requestURL)")
        // Do any additional setup after loading the view.
        
        self.view .addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        webView.load(URLRequest.init(url: requestURL!))
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(otherApplicationsOpen))
    }

    @objc private func otherApplicationsOpen() {
        let documentController = UIDocumentInteractionController.init(url: self.requestURL!)
        //documentController.delegate = self
        documentController.presentOptionsMenu(from: self.navigationItem.rightBarButtonItem!, animated: true)
        
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
