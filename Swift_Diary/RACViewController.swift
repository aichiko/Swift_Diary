//
//  RACViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/16.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift

class RACViewController: UIViewController {
    @available(iOS 2.0, *)
    lazy var person = Person.init(name: "ash")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "RAC_demo"
        // Do any additional setup after loading the view.
        
        let label = UILabel.init()
        label.textAlignment = .center
        label.text = "333"
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        let title: String = "3333"
        label.text = title
        label.text = person.name
        debugPrint(label.reactive.text.lifetime)
        //label.reactive.text <~ person.name
        
        let textField = UITextField.init()
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(label)
            make.top.equalTo(100)
            make.width.equalTo(200)
        }
        
        let textFieldResult = textField.reactive.textValues.map { (string) -> String in
            string!.appending("-sss")
        }.observe(on: QueueScheduler.main).observe { (even) in
            debugPrint(even)
        }
        debugPrint(textFieldResult!)
        
        textField.reactive.values(forKeyPath: "text").start()
        
        
        let button = UIButton.init(type: .system)
        button.setTitle("Button", for: .normal)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(label)
            make.top.equalTo(label.snp.bottom).offset(20)
        }
        
        // Notify after every time `viewWillAppear(_:)` is called.
        let appearing = view.reactive.trigger(for: #selector(viewWillAppear(_:)))
        appearing.observe { (even) in
            debugPrint(even)
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
