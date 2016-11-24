//
//  RACViewModel.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/24.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result


class RACViewModel: NSObject {
    let titleSignal: Signal<String, NoError>
    
    var title: String?
    
    init(title: String) {
        self.title = title
        self.titleSignal = Signal<String, NoError>.pipe().0
    }
    
    func getdata() -> Data {
        return Data.init(count: 3)
    }
}
