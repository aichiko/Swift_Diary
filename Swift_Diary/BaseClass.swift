//
//  BaseClass.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/2.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import Foundation


class BaseClass {
    
}

/*
 除构造方法、析构方法外的其他方法的参数默认除了第一个参数是局部参数，从第二个参数开始既是局部参数又是外部参数（这种方式和ObjC的调用方式很类似，当然，可以使用“#”将第一个参数同时声明为外部参数名，也可以使用“_”将其他参数设置为非外部参数名）。但是，对于函数，默认情况下只有默认参数既是局部参数又是外部参数，其他参数都是局部参数。
 构造方法的所有参数默认情况下既是外部参数又是局部参数；
 Swift中的构造方法分为“指定构造方法”和“便利构造方法（convenience）”，指定构造方法是主要的构造方法，负责初始化所有存储属性，而便利构造方法是辅助构造方法，它通过调用指定构造方法并指定默认值的方式来简化多个构造方法的定义，但是在一个类中至少有一个指定构造方法。
 */
class Person: BaseClass {
    //定义属性
    public private(set) var name: String
    var height: Double
    var age = 0
    //指定构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(name:String,height:Double,age:Int){
        self.name=name
        self.height=height
        self.age=age
        debugPrint("Person init...")
    }
    
    convenience init(name: String) {
        self.init(name:name,height:0.0,age:0)
    }
    
    //实例方法
    func modifyInfoWithAge(age:Int,height:Double){
        self.age=age
        self.height=height
    }
    
    //类型方法
    class func showClassName() {
        debugPrint("Class name is \"Person\"")
    }
    
    //析构方法，在对象被释放时调用,类似于ObjC的dealloc，注意此函数没有括号，没有参数，无法直接调用
    deinit {
        debugPrint("\(self) deinit...")
    }
}

/*
 下标脚本
 
 下标脚本是一种访问集合的快捷方式，例如：var a:[string],我们经常使用a[0]、a[1]这种方式访问a中的元素，0和1在这里就是一个索引，通过这种方式访问或者设置集合中的元素在Swift中称之为“下标脚本”（类似于C#中的索引器）。从定义形式上通过“subscript”关键字来定义一个下标脚本，很像方法的定义，但是在实现上通过getter、setter实现读写又类似于属性。假设用Record表示一条记录，其中有多列，下面示例中演示了如何使用下标脚本访问并设置某一列的值。
 */

class Record: BaseClass {
    //定义属性，假设store是Record内部的存储结构
    var store: [String: String]
    
    init(data: [String: String]) {
        self.store = data
    }
    //下标脚本（注意也可以实现只有getter的只读下标脚本）
    subscript(index: Int) -> String {
        get {
            let key = Array(self.store.keys).sorted()[index]
            return self.store[key]!
        }
        set {
            let key = Array(self.store.keys).sorted()[index]
            self.store[key] = newValue
        }
    }
    //下标脚本（重载）
    subscript(key:String)->String{
        get{
            return store[key]!
        }
        set{
            store[key] = newValue
        }
    }
}

/*
 关于继承
 和ObjC一样，Swift也是单继承的（可以实现多个协议，此时协议放在后面），子类可以调用父类的属性、方法，重写父类的方法，添加属性监视器，甚至可以将只读属性重写成读写属性。
 */
class People {
    var firstName: String, lastName: String
    var age: Int = 0
    var fullName: String {
        get {
            return firstName+" "+lastName
        }
    }
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    func showMessage(){
        debugPrint("name=\(fullName),age=\(age)")
    }
    //通过final声明，子类无法重写
    final func sayHello() {
        debugPrint("hello world.")
    }
}

class Student: People {
    //重写属性监视器
    override var firstName: String {
        willSet {
            debugPrint("oldValue=\(firstName)")
        }
        didSet {
            debugPrint("newValue=\(firstName)")
        }
    }
    var score:Double
    
    //子类指定构造方法一定要调用父类构造方法
    //并且必须在子类存储属性初始化之后调用父类构造方法
    init(firstName: String, lastName: String, score: Double) {
        self.score=score
        super.init(firstName: firstName, lastName: lastName)
    }
    
    //将只读属性重写成了可写属性
    override var fullName: String {
        get{
            return super.fullName;
        }
        set{
            let array = ["sss", "ccc"]
            if array.count == 2 {
                firstName=array[0]
                lastName=array[1]
            }
        }
    }
    //重写方法
    override func showMessage() {
        debugPrint("name=\(fullName),age=\(age),score=\(score)")
    }
}

/*
 在使用ObjC开发时init构造方法并不安全，首先无法保证init方法只调用一次，其次在init中不能访问属性。但是这些完全依靠文档约定，编译时并不能发现问题，出错检测是被动的。在Swift中构造方法(init)有了更为严格的规定：构造方法执行完之前必须保证所有存储属性都有值。这一点不仅在当前类中必须遵循，在整个继承关系中也必须保证，因此就有了如下的规定：
 
 子类的指定构造方法必须调用父类构造方法，并确保调用发生在子类存储属性初始化之后。而且指定构造方法不能调用同一个类中的其他指定构造方法；
 便利构造方法必须调用同一个类中的其他指定构造方法（可以是指定构造方法或者便利构造方法），不能直接调用父类构造方法（用以保证最终以指定构造方法结束）；
 如果父类仅有一个无参构造方法（不管是否包含便利构造方法），子类的构造方法默认就会自动调用父类的无参构造方法（这种情况下可以不用手动调用）；
 常量属性必须默认指定初始值或者在当前类的构造方法中初始化，不能在子类构造方法中初始化；
 */

