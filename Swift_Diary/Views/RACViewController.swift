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
import Result

private class SearchResult: NSObject {
    var string: String?
    var bn_title: String?
    var bn_mobilepath: String?
    var bn_http: String?
    
    init(string: String?) {
        self.string = string
    }
    
    convenience override init() {
        self.init(string: "ash")
    }
}

class LabelBinding {
    var name: BindingTarget<String>
    init(lifetime: Lifetime) {
        self.name = BindingTarget.init(lifetime: lifetime, setter: { (value) in
            
        })
    }
}

class RACViewController: UIViewController {
    @available(iOS 2.0, *)
    
    lazy var viewModel = RACViewModel.init(title: "ash")
    lazy var person = Person.init(name: "ash")
    lazy var dispose: Disposable? = nil
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
        //debugPrint(label.reactive.text.lifetime)
        
        let textField = UITextField.init()
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(label)
            make.top.equalTo(100)
            make.width.equalTo(200)
        }
        
        /*
        property的当前值可以通过获取 value获得。 producer返回一个会一直发送值变化信号生成者（signal producer ），
        
        <~运算符是提供了几种不同的绑定属性的方式。注意这里绑定的属性必须是 MutablePropertyType类型的。
        
        property <~ signal 将一个属性和信号绑定在一起，属性的值会根据信号送过来的值刷新。
        property <~ producer 会启动这个producer，并且属性的值也会随着这个产生的信号送过来的值刷新。
        property <~ otherProperty将一个属性和另一个属性绑定在一起，这样这个属性的值会随着源属性的值变化而变化。
        DynamicProperty 类型用于桥接OC的要求KVC或者KVO的API，比如 NSOperation。要提醒的是大部分AppKit和UIKit的属性都不支持KVO，所以要观察它们值的变化需要通过其他的机制。相比 DynamicProperty要优先使用  MutablePropertyType类型。
        */
        label.reactive.text <~ textField.reactive.continuousTextValues
        
        /// 下面的demo可以通过RAC来实现 textField的实时搜索功能
        let textFieldStrings = textField.reactive.continuousTextValues
        let searchResults = textFieldStrings
            .flatMap(.latest) { (query: String?) -> SignalProducer<(Data, URLResponse), NSError> in
                let request = self.makeSearchRequest(escapedQuery: query)
                return URLSession.shared.reactive
                    .data(with: request)
                    .retry(upTo: 2)
                    .flatMapError({ (error) in
                    print("Network error occurred: \(error)")
                    return SignalProducer.empty
                })
        }
        .map { (data, response) -> [SearchResult] in
            let string = String.init(data: data, encoding: .utf8)
            //将data解析为json数据
            do {
                let dic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                debugPrint(dic)
                let arr = dic["data"]
                debugPrint(arr as! [Any])
            }catch {
                debugPrint(error)
            }
            return [SearchResult.init(string: string)]
        }
        .throttle(1.5, on: QueueScheduler.main)
        .take(until: self.reactive.trigger(for: #selector(viewDidDisappear(_:))))
        //暂时只能这样自动管理信号的dispose
        //不加上take 会导致textField释放不掉，整个视图也会无法释放
        /*
         用操作符管理生命周期比通过disposal手动管理更好
         虽然利用从 start返回的disposable取消一个信号生产者非常容易，显式的使用disposable可以快速的清理资源并且让代码整洁。
         
         但是总是有更高端的操作符可以替换这些手动的disposal：
         
         take可以在接收到指定次数的值后自动终结流
         takeUntil可以在指定某个事件发生后自动终结信号或者信号生产者（比如当一个"取消"按钮点击）
         属性和<~操作符可以用于绑定一个信号或者信号生产者的结果，直到终结或者直到属性被销毁。这可以替代收到观察一个值查并且设置到某个地方
         */
        
        self.dispose = searchResults.observe { event in
            //event 是一个枚举类型
            switch event {
            case let .value(values):
                debugPrint("Search results: \(values.first?.string)")
            case let .failed(error):
                print("Search error: \(error)")
            case .completed, .interrupted:
                debugPrint("search completed!!!")
                break
            }
        }
        //textField.reactive.values(forKeyPath: "text").start()
        
        let button = UIButton.init(type: .system)
        button.setTitle("Push", for: .normal)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(label)
            make.top.equalTo(label.snp.bottom).offset(20)
        }
        // Notify after every time `viewWillAppear(_:)` is called.
        
        let signalProducer = SignalProducer<Bool, NoError>.init(value: true)
        
        let action: Action<((UIButton) ->Void), Bool, NoError> = Action.init { (button) in
            debugPrint(button)
            return signalProducer
        }
        
        button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
    }
    
    func makeSearchRequest(escapedQuery: String?) -> URLRequest {
        return URLRequest.init(url: URL.init(string:"http://meetliveapi.24hmb.com/api/GetBanner")!)
    }
    
    func buttonAction(button: UIButton) {
        debugPrint("button Action")
        let exampleVC = ExampleTableViewController()
        self.navigationController?.pushViewController(exampleVC, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //可以使用手动释放，感觉好蠢
        //self.dispose?.dispose()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        debugPrint("\(self) deinit")
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
