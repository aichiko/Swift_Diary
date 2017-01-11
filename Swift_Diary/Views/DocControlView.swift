//
//  DocControlView.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/1/10.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import UIKit

typealias Back = (_ controlView: DocControlView) ->Void
typealias Play = (_ controlView: DocControlView) ->Void

/// 文档视图的控制层
class DocControlView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var back: Back?
    var play: Play?

    let backButton = UIButton.init(type: .custom)
    
    //let titleLabel = UILabel()
    
    let playButton = UIButton.init(type: .custom)
    
    let fullButton = UIButton.init(type: .custom)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    private func configSubviews() {
        self.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        
        self.addSubview(backButton)
        self.addSubview(playButton)
        self.addSubview(fullButton)
        
        backButton.setImage(UIImage.init(named: "back"), for: .normal)
        playButton.setImage(UIImage.init(named: "video"), for: .normal)
        fullButton.setImage(UIImage.init(named: "minimizing"), for: .normal)
        
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
        fullButton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
    }
    
    @objc private func backAction(_ button: UIButton) {
        back!(self)
    }
    
    @objc private func playAction(_ button: UIButton) {
        if let play = play {
            play(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
