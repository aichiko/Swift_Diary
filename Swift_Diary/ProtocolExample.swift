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

//委托(代理)模式

class Dice {
    //let sides: Int
}

//你可以在协议的继承列表中，通过添加 class 关键字来限制协议只能被类类型采纳，而结构体或枚举不能采纳 该协议。
protocol DiceGame: class {
    var dice: Dice { get }
    
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

//跟OC的代理类似吧，我感觉swift 用到代理的时候很少。懵逼中。。。
//扩展可以用于添加协议，采纳协议

//关联类型
//定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的 某个类型提供了一个占位名(或者说别名)，其代表的实际类型在协议被采纳时才会被指定。你可以通过 atedtype 关键字来指定关联类型。

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript (i: Int) ->ItemType{ get }
}

struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int){
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    //typealias ItemType = Int
    //不加上这句话也会自己判断类型
    var count: Int {
        return items.count
    }
    mutating internal func append(item: Int) {
        self.push(item: item)
    }
    internal subscript(i: Int) -> Int {
        return items[i]
    }
}

//IntStack 结构体实现了 Container 协议的三个要求，其原有功能也不会和这些要求相冲突。
//此外， IntStack 在实现 Container 的要求时，指定 ItemType 为 Int 类型，即 typealias ItemType = In t ，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。

//你也可以让泛型 Stack 结构体遵从 Container 协议:
struct Stack<Element>: Container {
    // Stack<Element> 的原始实现部分 
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(item: Element) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//where 语句 让你能够为泛型函数或泛型类型的类型参数定义一些强制要求。
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anyContainer: C2) ->Bool
    where C1.ItemType == C2.ItemType,  C1.ItemType: Equatable {
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anyContainer.count {
            return false
        }
        
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anyContainer[i] {
                return false
            }
        }
        
        return true
}

/*
 这个函数的类型参数列表还定义了对两个类型参数的要求:

 */
