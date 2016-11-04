//
//  ProtocolExample.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/4.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import Foundation

//使用 protocol 来声明一个协议。
protocol ExampleProtocol {
    var simpleDescription: String { get }
    //在结构体、枚举中修改其变量需要使用mutating修饰（注意类不需要）
    mutating func adjust()
}

//类、枚举和结构体都可以实现协议。
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
/*
 
 */

//使用 extension 来为现有的类型添加功能，比如新的方法和计算属性。你可以使用扩展在别处修改定义，甚至是 从外部库或者框架引入的一个类型，使得这个类型遵循某个协议。
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
