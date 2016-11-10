//
//  ProtocolViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/4.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit

//使用采用 Error 协议的类型来表示错误。
enum PrinterError: Error {
    case OutOfPaper
    case NoToner
    case OnFire
}

//结构体和类是构造复杂数据类型时常用的构造体，在其他高级语言中结构体相比于类要简单的多（在结构体内部仅仅能定义一些简单成员），但是在Swift中结构体和类的关系要紧密的多，这也是为什么将结构体放到后面来说的原因。Swift中的结构体可以定义属性、方法、下标脚本、构造方法，支持扩展，可以实现协议等等，很多类可以实现的功能结构体都能实现，但是结构体和类有着本质区别：类是引用类型，结构体是值类型。

//注意对于类中声明类型方法使用关键字class修饰，但结构体里使用static修饰

class ProtocolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        NSLog("ProtocolViewController 加载完成")
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let a = SimpleClass()
        a.adjust()
        //let aDescription = a.simpleDescription
        debugPrint("simpleDescription == \(a.simpleDescription)")
        
        //检测协议
        let bool1 = a is ExampleProtocol //判断p是否遵循了ExampleProtocol协议
        if bool1 {
            debugPrint("s has ExampleProtocol property.")
        }
        
        //类型转化
        if let bool2 = a as? ExampleProtocol {
            //如果a转化成了ExampleProtocol类型则返回实例，否则为nil
             debugPrint("a' ExampleProtocol is \(a)") //结果:
        }
        
        var b: Int = 7
        b.adjust()
        debugPrint(b.simpleDescription)
        /*
         有多种方式可以用来进行错误处理。一种方式是使用 do-catch 。在 do 代码块中，使用 try 来标记可以抛出错误 的代码。在 catch 代码块中，除非你另外命名，否则错误会自动命名为 error 。
         */
        do {
            let printerResponse = try sendToPrinter("Never Has Toner")
            debugPrint(printerResponse)
        } catch {
            debugPrint(error)
        }
        //可以使用多个 catch 块来处理特定的错误。参照 switch 中的 case 风格来写 catch 。
        do {
            let printerResponse = try sendToPrinter("Never Has Toner")
            debugPrint(printerResponse)
        } catch PrinterError.OnFire {
            debugPrint("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            debugPrint("Printer error: \(printerError).")
        } catch {
            debugPrint(error)
        }
        
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        
        //使用 defer 代码块来表示在函数返回前，函数中最后执行的代码。无论函数是否会抛出错误，这段代码都将执 行。使用 defer ，可以把函数调用之初就要执行的代码和函数调用结束时的扫尾代码写在一起，虽然这两者的执 行时机截然不同。
        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            defer {
                fridgeIsOpen = false
            }
            let result = fridgeContent.contains(food)
            return result
        }
        debugPrint(fridgeContains("banana"))
        debugPrint(fridgeIsOpen)
        
        
        //泛型 在尖括号里写一个名字来创建一个泛型函数或者类型。
        /*
         泛型可以让你根据需求使用一种抽象类型来完成代码定义，在使用时才真正知道其具体类型。这样一来就好像在定义时使用一个占位符做一个模板，实际调用时再进行模板套用，所以在C++中也称为“模板”。泛型在Swift中被广泛应用，上面介绍的Array<>、Dictionary<>事实上都是泛型的应用。通过下面的例子简单看一下泛型参数和泛型类型的使用。
         */
        func repeatItem<Item> (repeating item: Item, numberOfTimes: Int) -> [Item] {
            var result = [Item]()
            for _ in 0..<numberOfTimes {
                result.append(item)
            }
            return result
        }
        let items = repeatItem(repeating: "knock", numberOfTimes:4)
        debugPrint(items)
        //你也可以创建泛型函数、方法、类、枚举和结构体。
        enum OptionalValue<Wrapped> {
            case None
            case Some(Wrapped)
        }
        var possibleInteger: OptionalValue<Int> = .None
        possibleInteger = .Some(100)
        
        debugPrint("possibleInteger == \(possibleInteger)")
        //在类型名后面使用 where 来指定对类型的需求，比如，限定类型实现某一个协议，限定两个类型是相同的，或者 限定某个类必须有一个特定的父类。
        
        //<T: Equatable> 和 <T where T: Equatable> 是等价的。
        
        let age = -3
        assert(age <= 0, "A person's age cannot be less than zero")
        /*
         使用断言进行调试
         断言会在运行时判断一个逻辑条件是否为 true 。从字面意思来说，断言“断言”一个条件是否为真。你可以使 用断言来保证在运行其他代码之前，某些重要的条件已经被满足。如果条件判断为 true ，代码运行会继续进 行;如果条件判断为 false ，代码执行结束，你的应用被终止。
         如果你的代码在调试环境下触发了一个断言，比如你在 Xcode 中构建并运行一个应用，你可以清楚地看到不合法 的状态发生在哪里并检查断言被触发时你的应用的状态。此外，断言允许你附加一条调试信息。
         你可以使用全局 assert(_:_:file:line:) 函数来写一个断言。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示:
         let age = -3
         assert(age >= 0, "A person's age cannot be less than zero") // 因为 age < 0，所以断言会触发
         在这个例子中，只有 age >= 0 为 true 的时候，即 age 的值非负的时候，代码才会继续执行。如果 age 的值是负数，就像代码中那样， age >= 0 为 false ，断言被触发，终止应用。
         
         何时使用断言
         当条件可能为假时使用断言，但是最终一定要保证条件为真，这样你的代码才能继续运行。断言的适用情景:
         • 整数类型的下标索引被传入一个自定义下标实现，但是下标索引值可能太小或者太大。 • 需要给函数传入一个值，但是非法的值可能导致函数不能正常执行。
         • 一个可选值现在是 nil ，但是后面的代码运行需要一个非 nil 值。
         */
        
        //闭包引起的循环强引用
        
        let heading = HTMLElement(name: "ash")
        let defaultText = "some default text"
        
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
        }
        debugPrint(heading.asHTML)
 
        //运行了asHtml 导致造成了强引用。
        
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        debugPrint(paragraph!.asHTML())
        // 打印 “<p>hello, world</p>”
        paragraph = nil
        
    }
    //使用 throw 来抛出一个错误并使用 throws 来表示一个可以抛出错误的函数。如果在函数中抛出一个错误，这个函 数会立刻返回并且调用该函数的代码会进行错误处理。
    func sendToPrinter(_ printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.NoToner
        }
        return "Job send"
    }
    
    deinit {
        debugPrint("\(self) is being deinitialized")
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
