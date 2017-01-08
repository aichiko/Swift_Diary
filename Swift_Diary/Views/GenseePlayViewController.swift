//
//  GenseePlayViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/1/6.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import UIKit
import PlayerSDK

class GenseePlayViewController: UIViewController, GSPPlayerManagerDelegate {
    
    
    
    private let videoView = GSPVideoView.init()
    
    private let docView = GSPDocView.init()
    
    private let playerManager: GSPPlayerManager = GSPPlayerManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "change", style: .done, target: self, action: #selector(switchVideoOrAudie(barItem:)))
        self.view.addSubview(videoView)
        self.view.addSubview(docView)
        
//        videoView.snp.makeConstraints { (make) in
//            make.top.equalTo(64)
//            make.width.equalToSuperview()
//            make.height.equalTo(videoView.snp.width).multipliedBy(0.5625)
//            make.centerX.equalToSuperview()
//        }
        
        joinGenseeVideo()
    }

    @objc private func switchVideoOrAudie(barItem: UIBarButtonItem) {
        
    }
    
    /// 加入展示互动直播
    private func joinGenseeVideo() {
        //Video View
        let videoViewRect = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.width*9/16)
        videoView.frame = videoViewRect
//        videoView.videoLayer.backgroundColor = UIColor.red.cgColor
        
        playerManager.delegate = self
        playerManager.enableAudio(true)
        playerManager.enableVideo(true)
        playerManager.videoView = videoView
        playerManager.docView = docView
        
        videoView.contentMode = .scaleToFill
        
        let joinParam = GSPJoinParam()
        joinParam.domain = "24hmb.gensee.com"
        joinParam.serviceType = .webcast;
        joinParam.roomNumber = "43466758"
        joinParam.nickName = "222"
        joinParam.oldVersion = false
        playerManager.join(with: joinParam)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - GSPPlayerManagerDelegate
    public func playerManager(_ playerManager: GSPPlayerManager!, didReceiveSelfJoinResult joinResult: GSPJoinResult, currentIDC idcKey: String!) {
        debugPrint("joinResult === \(joinResult.rawValue)")
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
