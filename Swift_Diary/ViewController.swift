//
//  ViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/1.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let col = UIColor.orange
        self.view.backgroundColor = col
        self.navigationItem.title = "基础部分"
        baseFoundation()
        
        controlFlow()
        
        methodClosure()
    }
    
    /// 基础部分
    func baseFoundation(){
        //for 循环
        for i in 0  ..< 10  {
            debugPrint(i+1)
        }
        print("-----------")
        var arr:Array<Int> = [1,2,3]
        //追加元素,也可以用下面那种方法
        arr.append(4)
        arr+=[5,6]
        for j in 0 ..< arr.count {
            debugPrint(j+1)
        }
        
        //使用构造函数限制数组元素个数并且指定默认值，自动推断类型
        var c = Array.init(repeating: 1, count: 3)
        
        
        //Set表示没有顺序的集合：
        var a:Set<String> = ["hello","world"]
        var b:Set=[1,2] //类型推断：Set<Int>
        a.insert("!")//注意这个插入不保证顺序
        
        //方法命名
        func sum (a:Int) ->Int{
            return a+1
        }
        
        //增加的新方法，第一个大于1的元素
        let first = arr.first { (element) -> Bool in
            element > 1
        }
        debugPrint(first ?? 0)
        
        //现在不需要像OC那样打印
        debugPrint("returnValue===\(sum(a: 2))")
        
        let width = "the width is"
        let widthValue = 55
        let finalWidth = width + String(widthValue)
        
        debugPrint("finalWidth == \(finalWidth)")
        
        
        //元组（Tuple）
        //在开发过程中有时候会希望临时组织一个数据类型，此时可以使用一个结构体或者类，但是由于这个类型并没有那么复杂，如果定义起来又比较麻烦，此时可以考虑使用元组。
        
        var point = (x:100,y:200)
        point.x = 200
        _ = point
        
        let httpStatus:(Int,String)=(200,"success") //元组的元素类型并不一定相同
        let (status,description)=httpStatus //一次性赋值给多个变量，此时status=200，description="success"
        debugPrint("status == \(status),description == \(description)")
        //接收元组的其中一个值忽略另一个值使用"_"(注意在Swift中很多情况下使用_忽略某个值或变量)
        let (sta,_)=httpStatus
        debugPrint("sta=\(sta)") //结果：sta=200
        
        //可选类型
        
        //所谓可选类型就是一个变量或常量可能有值也可能没有值则设置为可选类型。在ObjC中如果一个对象类型没有赋值，则默认为nil，同时nil类型也只能作为对象类型的默认值，对于类似于Int等基本类型则对应0这样的默认值。由于Swift是强类型语言，如果在声明变量或常量时没有进行赋值，Swift并不会默认设置初值（这一点和其他高级语言不太一样，例如C#虽然也有可选类型，但是要求并没有那么严格）。
        var float:Float?//使用？声明成一个可选类型，如果不赋值默认为nil
        float = 172
        let float1:Float=60.0
        
        //let float2 = float! + float1 //注意此句报错，因为Int和Int？根本就是两种不同的类型，在Swift中两种不同的类型不能运算（因为不会自动进行类型转化）
        _ = float! + float1//使用！进行强制解包
        
        let age = "29"
        let ageInt = Int(age)!
        
        debugPrint("age == \(age), ageInt == \(ageInt)")
        
        /**
         * 区间运算符,通常用于整形或者字符范围(例如"a"..."z"）
         */
        for i in 1...5 { //闭区间运算符...（从1到5，包含5）
            debugPrint("i=\(i)")
        }
        
        for i in 1..<5{ //半开区间运算符..<(从1到4)
            debugPrint("i=\(i)")
        }
        
        //var str:String = "hello world!"
        //let range = "a"..."z"
        //        for var t in str {
        //
        //        }
        
        //空合运算符（Nil Coalescing Operator）
        let defaultColorName = "red"
        var userDefinedColorName: String?   //默认值为 nil
        
        let colorNameToUse = userDefinedColorName ?? defaultColorName
        // userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"
        debugPrint("colorNameToUse == \(colorNameToUse)")
        //?? 两个问号后面代表的是默认值，为空则使用默认值
    }
    
    /// 控制流
    func controlFlow() {
        //控制流
        
        //Swift中的多数控制流和其他语言差别并不大，例如for、while、do while、if、switch等，而且有些前面已经使用过（例如for in循环），这里将着重介绍一些不同点。
        var a = ["a","b","c","d","e","f","g"]
        let b = a[1]
        
        /**
         *  switch支持一个case多个模式匹配，同时case后不用写break也会在匹配到种情况后自动跳出匹配，不存在隐式贯穿，如果想要贯穿在case之后添加"fallthrough"关键字
         */
        switch b {
        case "a","b":
            debugPrint("b==a or b==b")
        case "b","c","d","e","f":
            debugPrint("b in (c,d,e,f)")
        default:
            debugPrint("b==g")
        }
        //虽然下面的条件也符合，但是下面的不会走，第一个符合之后会自动跳出匹配
        /**
         * 匹配区间,同时注意switch必须匹配所有情况，否则必须加上default
         */
        let c:Int = 88
        switch c {
        case 1...60:
            debugPrint("1-60")
        case 61...90:
            debugPrint("61-90")
        case 91...100:
            debugPrint("91-100")
        default:
            debugPrint("1>c>100")
        }
        /**
         *  元组匹配、值绑定、where条件匹配
         *  注意下面的匹配没有default，因为它包含了所有情况
         */
        let d=(x:900,y:90)
        switch d{
        case (0,0):
            debugPrint("d in (0,0)")
        case (_,0): //忽略x值匹配
            debugPrint("d in y")
        case (0,let y)://值绑定
            debugPrint("d in x,y=\(y)")
        case (-100...100,-100...100): //注意这里有可能和第一、二、三个条件重合，但是Swift允许多个case匹配同一个条件，但是只会执行第一个匹配
            debugPrint("x in（0-100），y in （0-100）")
        case let (x,y) where x==y: //where条件匹配,注意这里的写法等同于：(let x,let y) where x==y
            debugPrint("x=y=\(x)")
        case let (x, y):
            debugPrint("x=\(x),y=\(y)")
        }
        
        //在其他语言中通常可以使用break、continue、return（Swift中添加了fallthrough）等来终止或者跳出某个执行语句，但是对于其行为往往是具有固定性的，例如break只能终止其所在的内层循环，而return只能跳出它所在的函数。在Swift中这种控制转移功能得到了加强，那就是使用标签。利用标签你可以随意指定转移的位置，例如下面的代码演示了如何直接通过标签跳出最外层循环：
        let e = 5
        whileLoop:
        while e-1 > 0 {
            for i in 0...e {
                debugPrint("e==\(e),i==\(i)")
                break whileLoop
                //如果此处直接使用break将跳出for循环，而由于这里使用标签直接跳出了while，结果只会打印一次，其结果为：e=5,i=0
            }
        }
    }
    
    /// 函数和闭包
    func methodClosure() {
        //函数是一个完成独立任务的代码块，Swift中的函数不仅可以像C语言中的函数一样作为函数的参数和返回值，而且还支持嵌套，并且有C#一样的函数参数默认值、可变参数等。
        //感觉跟js的很类似。外部参数，局部参数不是很明白
        
        func sum(a:Int, b:Int) ->Int{
            return a+b
        }
        //sum(a: 1, b: 2)
        
        /*
         可以看到Swift中的函数仅仅表达形式有所区别(定义形式类似于Javascript，但是js不用书写返回值)，但是本质并没有太大的区别。不过Swift中对函数参数强调两个概念就是局部参数名（又叫“形式参数”）和外部参数名，这极大的照顾到了ObjC开发者的开发体验。在上面的例子中调用sum函数并没有传递任何参数名，因为num1、num2仅仅作为局部参数名在函数内部使用，但是如果给函数指定一个外部参数名在调用时就必须指定参数名。另外前面也提到关于Swift中的默认参数、可变长度的参数，包括一些高级语言中的输入输出参数，通过下面的例子大家会有一个全面的了解。
         */
        
        func greet(name: String, day: String) -> String {
            return "Hello \(name), today is \(day)."
        }
        debugPrint(greet(name:"Bob", day: "Tuesday"))
        //默认情况下，函数使用它们的参数名称作为它们参数的标签，在参数名称前可以自定义参数标签，或者使用 _ 表示不使用参数标签。
        func greet1(_ name: String, day: String) -> String {
            return "Hello \(name), today is \(day)."
        }
        debugPrint(greet1("ash", day: "sss"))
        
        //使用元组来让一个函数返回多个值。该元组的元素可以用名称或数字来表示。
        func calculateStatistics(scores:[Int]) ->(min: Int, max: Int, sum: Int){
            var min = scores[0]
            var max = scores[0]
            var sum = 0
            
            for score in scores {
                if score > max {
                    max = score
                } else if score < min {
                    min = score }
                sum += score
            }
            return (min, max, sum)
        }
        
        let result = calculateStatistics(scores: [5,3,100,3,9])
        debugPrint(result.sum)
        debugPrint(result.2)
        //用result.2 也可以代替 result.sum，得到的结果是一样的
        
        //函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式:
        func sumOf(numbers: Int...) -> Int {
            var sum = 0
            for number in numbers {
                sum += number
            }
            return sum
        }
        //sumOf()
        //sumOf(numbers: 42, 597, 12)
        //可以不传参数
        
        //函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函
        //数。
        //函数是第一等类型，这意味着函数可以作为另一个函数的返回值。
        //函数也可以当做参数传入另一个函数。
        
        //函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包所建作用域中能得到的变 量和函数，即使闭包是在一个不同的作用域被执行的 - 你已经在嵌套函数例子中所看到。你可以使用 {} 来创建 一个匿名闭包。使用 in 将参数和返回值类型声明与闭包函数体进行分离。
        func makeIncrementer () ->((Int) ->Int){
            func addOne(num:Int) ->Int{
                return num + 1
            }
            return addOne
        }
        
        func hasAnyMatches(lists:[Int], condition: (Int) ->Bool) ->Bool{
            for item in lists {
                if condition(item) {
                    return true
                }
            }
            return false
        }
        
        func lessThanTen(number: Int) -> Bool {
            return number < 10
        }
        
        let numbers = [20,19,7,12]
        _ = hasAnyMatches(lists: numbers, condition: lessThanTen)
        
        
        let arr = numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        debugPrint(arr)
        
        /*
         在Swift中闭包表达式的定义形式如下：
         
         { ( parameters ) -> returnType in
         
         statements
         
         }
         
         */
        
        //有很多种创建更简洁的闭包的方法。如果一个闭包的类型已知，比如作为一个回调函数，你可以忽略参数的类型
        //和返回值。单个语句闭包会把它语句的值当做结果返回。
        let mappedNumbers = numbers.map({ number in 3 * number })
        debugPrint(mappedNumbers)
        
        //你可以通过参数位置而不是参数名字来引用参数——这个方法在非常短的闭包中非常有用。当一个闭包作为最后
        //一个参数传给一个函数的时候，它可以直接跟在括号后面。当一个闭包是传给函数的唯一参数，你可以完全忽略
        //括号。
        let sortedNumbers = numbers.sorted { $0 > $1 }
        debugPrint(sortedNumbers)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

