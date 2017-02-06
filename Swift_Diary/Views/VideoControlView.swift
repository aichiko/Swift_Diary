//
//  VideoControlView.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/2/6.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import UIKit

typealias FullScreen = (_ controlView: VideoControlView) ->Void

/// 直播视图的控制层
class VideoControlView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var fullScreen: FullScreen?
    
    let backButton = UIButton.init(type: .custom)
    
    //let titleLabel = UILabel()
    
    let playButton = UIButton.init(type: .custom)
    
    let fullButton = UIButton.init(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubviews() {
        self.addSubview(backButton)
        self.addSubview(playButton)
        self.addSubview(fullButton)
        
        backButton.setImage(UIImage.init(named: "back"), for: .normal)
        playButton.setImage(UIImage.init(named: "video"), for: .normal)
        playButton.setImage(UIImage.init(named: "videoplay"), for: .selected)
        fullButton.setImage(UIImage.init(named: "maximization"), for: .normal)
        fullButton.setImage(UIImage.init(named: "minimizing"), for: .selected)
        
        backButton.setTitle("会议标题", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        backButton.titleLabel?.font = UIFont.init(name: "PingFang-SC-Regular", size: 18)
        
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        
        backButton.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(300)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.width.height.equalTo(50)
        }
        
        fullButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.width.height.equalTo(50)
        }
        
        backButton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        fullButton.addTarget(self, action: #selector(fullscreenAction(_:)), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
    }
    
    @objc private func fullscreenAction(_ button: UIButton) {
        NSLog("点击直播全屏")
        if let fullScreen = fullScreen {
            fullScreen(self)
        }
        button.isSelected = !button.isSelected
    }
    
    @objc private func backAction(_ button: UIButton) {
        if let fullScreen = fullScreen {
            fullScreen(self)
        }
    }
    
    @objc private func playAction(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
    }
}
