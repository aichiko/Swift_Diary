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
        
        baseFoundation()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

