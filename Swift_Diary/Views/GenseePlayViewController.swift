//
//  GenseePlayViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/1/6.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import UIKit
import PlayerSDK
import Foundation

extension GSPDocView {
    func interfaceOrientation(orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}

extension UIColor {
    class func colorWithString(_ color: (rgb: String, alpha: Float)) -> UIColor {
        var cString = color.rgb.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(color.alpha))
    }
    
    class func colorWithString(_ rgb: String) -> UIColor{
        return UIColor.colorWithString((rgb, 1.0))
    }
}

class GenseePlayViewController: UIViewController, GSPPlayerManagerDelegate {
    
    private let textLabel = UILabel.init()
    
    private let docFullscreenButton = UIButton.init(type: .custom)
    
    private let videoView = GSPVideoView.init()
    
    private let docView = GSPDocView.init()
    
    private let playerManager: GSPPlayerManager = GSPPlayerManager.shared()
    
    private let controlView = DocControlView()
    
    private let audioView = UIImageView.init(image: UIImage.init(named: "Group 2"))
    
    private var isplayVideo = true//默认为true
    
    private var isFullScreen = false//是否为全屏 默认为false
    
    private var videoHeight: CGFloat?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    //设置隐藏动画
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .default;
        self.navigationController?.navigationBar.barTintColor = UIColor.colorWithString("#57BF64")
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "会议标题"
        
        let rightItem = UIButton.init(type: .custom)
        rightItem.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
        rightItem.setImage(UIImage.init(named: "audio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        rightItem.setImage(UIImage.init(named: "video")?.withRenderingMode(.alwaysOriginal), for: .selected)
        rightItem.addTarget(self, action: #selector(switchVideoOrAudie(barItem:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItem)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(backAction(barItem:)))
        
//        videoView.snp.makeConstraints { (make) in
//            make.top.equalTo(64)
//            make.width.equalToSuperview()
//            make.height.equalTo(videoView.snp.width).multipliedBy(0.5625)
//            make.centerX.equalToSuperview()
//        }
        
        videoHeight = self.view.bounds.size.width*9/16
        
        joinGenseeVideo()
        
        configSubviews()
    }
    
    ///
    private func configSubviews() {
        self.view.addSubview(audioView)
        audioView.alpha = 0
        audioView.snp.makeConstraints { (make) in
            make.center.equalTo(self.videoView)
        }
        
        self.view.addSubview(textLabel)
        textLabel.text = "文档"
        textLabel.font = UIFont.init(name: "PingFang-SC-Medium", size: 16)
        textLabel.textColor = UIColor.colorWithString("333333")
        textLabel.frame = CGRect(x: 15, y: 64+videoHeight!, width: self.view.bounds.size.width, height: 42)
        self.view.addSubview(docFullscreenButton)
        
        docFullscreenButton.setImage(UIImage.init(named: "maximization"), for: .normal)
//        docFullscreenButton.setImage(UIImage.init(named: "minimizing"), for: .selected)
        docFullscreenButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(textLabel)
            make.right.equalTo(self.view).offset(0)
            make.width.height.equalTo(42)
        }
        docFullscreenButton.addTarget(self, action: #selector(fullscreenAction(button:)), for: .touchUpInside)
        
        self.view.addSubview(docView)//最后加上docView 使其在self的最上层
        controlView.frame = docView.bounds
        docView.addSubview(controlView)
        controlView.isHidden = !isFullScreen
        controlView.back = {
            controlView in
            self.docView.interfaceOrientation(orientation: .portrait)
        }
        
        controlView.play = {
            controlView in
            NSLog("点击播放或者暂停")
        }
    }
    
    @objc private func fullscreenAction(button: UIButton) {
        NSLog("点击文档全屏")
        docView.interfaceOrientation(orientation: .landscapeLeft)
    }
    
    /// 音频视频切换
    @objc private func switchVideoOrAudie(barItem: UIButton) {
        isplayVideo = !isplayVideo
        playerManager.enableVideo(isplayVideo)
        barItem.isSelected = !barItem.isSelected
        UIView.animate(withDuration: 0.2) { 
            //
            if self.isplayVideo {
                self.audioView.alpha = 0
            }else {
                self.audioView.alpha = 1.0
            }
        }
    }
    
    /// 返回并推出直播
    @objc private func backAction(barItem: UIBarButtonItem) {
        playerManager.leave()
        playerManager.invalidate()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /// 加入展示互动直播
    private func joinGenseeVideo() {
        //Video View
        self.view.addSubview(videoView)
        
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
        
        docView.frame = CGRect(x: 0, y: 316, width: self.view.bounds.size.width, height: 218)
        docView.setGlkBackgroundColor(1, green: 1, blue: 1)
        docView.zoomEnabled = true//允许拖拽手势
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

    //iOS 8.0之后使用
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        NSLog("size === \(size) coordinator === \(coordinator)")
        if size.width>size.height {
            isFullScreen = true
            docView.frame.origin = CGPoint(x: 0, y: 0)
            docView.frame.size = size
            controlView.frame.size = size
            self.navigationController?.navigationBar.isHidden = true
            controlView.isHidden = false
//            self.navigationController?.navigationBar.subviews.first?.alpha = 0
        }else {
            isFullScreen = false
            controlView.isHidden = true
            let pointY = size.width*9/16 + 64 + 42
            docView.frame.origin = CGPoint(x: 0, y: pointY)//需要重新计算
            docView.frame.size = CGSize(width: size.width, height: 218)
            controlView.frame.size = CGSize(width: size.width, height: 218)
            self.navigationController?.navigationBar.isHidden = false
//            self.navigationController?.navigationBar.subviews.first?.alpha = 1.0
        }
    }
    //iOS 8.0之前使用
//    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//        
//    }
    
}
