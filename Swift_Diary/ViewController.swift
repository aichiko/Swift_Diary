//
//  ViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/1.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit

/// 枚举
private enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var dataArray = ["swift_Networking", "swift_RAC", "面向协议编程", "展示互动"]
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = self.dataArray[indexPath.row]
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let netVC = NetViewController()
            self.navigationController?.pushViewController(netVC, animated: true)
        }else if indexPath.row == 1 {
            let racVC = RACViewController()
            self.navigationController?.pushViewController(racVC, animated: true)
        }else if indexPath.row == 2 {
            let tableViewVC = ExampleTableViewController()
            self.navigationController?.pushViewController(tableViewVC, animated: true)
        }else if indexPath.row == 3 {
            let GenseeVC = GenseePlayViewController()
            self.navigationController?.pushViewController(GenseeVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let col = UIColor.orange
        self.view.backgroundColor = col
        self.navigationItem.title = "基础部分"
        //baseFoundation()
        
        //controlFlow()
        
        //methodClosure()
        
        //classAndObject()
        
        configTableView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action:#selector(barButtonAction(button:)))
    }
    
    func barButtonAction(button: UIBarButtonItem) {
        //debugPrint(button)
        let vc = ProtocolViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configTableView() {
        let tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
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
        
        var str:String = "hello world!"
        let range = "a"..."z"
        for character in str.characters {
            if range.contains(String(character)) {
                print(character) //结果：helloworld
            }
        }
        
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
        let d=(x:90,y:90)
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
    
    /// 类和方法
    func classAndObject() {
        
        // 关于类的一些补充
        let person = Person.init(name: "ash")
        Person.showClassName()
        //打印用法跟OC的一样，只是后面会有一个变量，可以不写
        NSLog("ssss %@", person.name)
        
        let record = Record.init(data: ["name":"kenshin","sex":"male"])
        // 重写了下标脚本
        debugPrint("record[0] == \(record[0])") //结果：r[0]=kenshin
        record["sex"] = "female"
        debugPrint("record[1] == \(record[1])") //结果：female
        
        let s = Student.init(firstName: "ash", lastName: "222", score: 33)
        s.firstName="kenshin"
        s.showMessage()
        debugPrint("fullName == \(s.fullName)")
        
        class Shape {
            var numberOfSides = 0
            func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            }
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        //使用 class 和类名来创建一个类。类中属性的声明和常量、变量声明一样，唯一的区别就是它们的上下文是 类。同样，方法和函数声明也一样。
        
        let shape = Shape.init(name: "ash")
        shape.numberOfSides = 7
        _ = shape.simpleDescription()
        /*
        注意 self 被用来区别实例变量。当你创建实例的时候，像传入函数参数一样给类传入构造器的参数。每个属性都 需要赋值——无论是通过声明(就像 numberOfSides )还是通过构造器(就像 name )。
        如果你需要在删除对象之前进行一些清理工作，使用 deinit 创建一个析构函数。 子类的定义方法是在它们的类名后面加上父类的名字，用冒号分割。创建类的时候并不需要一个标准的根类，所
        以你可以忽略父类。
        子类如果要重写父类的方法的话，需要用 override 标记——如果没有添加 override 就重写父类方法的话编译器 会报错。编译器同样会检测 override 标记的方法是否确实在父类中。
         */
        
        class Square: Shape {
            var sideLength: Double = 0.0
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 4
            }
            
            //注意设置默认值0.0时监视器不会被调用
            var balance:Double=1.0{
                willSet{
                    self.balance=2.0
                    //注意newValue可以使用自定义值,并且在属性监视器内部调用属性不会引起监视器循环调用,注意此时修改balance的值没有用
                    debugPrint("Square.balance willSet,newValue=\(newValue),value=\(self.balance)")
                }
                didSet{
                    self.balance=3.0
                    //注意oldValue可以使用自定义值,并且在属性监视器内部调用属性不会引起监视器循环调用，注意此时修改balance的值将作为最终结果
                    debugPrint("Square.balance didSet,oldValue=\(oldValue),value=\(self.balance)")
                }
            }
            
            func area() ->  Double {
                return sideLength * sideLength
            }
            
            /// 重写父类的方法，需要加上 override
            override func simpleDescription() -> String {
                return "A square with sides of length \(sideLength)."
            }
            //除了储存简单的属性之外，属性可以有 getter 和 setter 。
            var perimeter: Double {
                get {
                    return 3.0 * sideLength
                }set {
                    sideLength = newValue / 3.0
                }
            }
        }
        
        let square = Square.init(sideLength: 3.1, name: "a dog")
        debugPrint("perimeter == \(square.perimeter)")//get
        square.perimeter = 9.9//set
        debugPrint("perimeter == \(square.sideLength)")
        /*
         在 perimeter 的 setter 中，新值的名字是 newValue 。你可以在 set 之后显式的设置一个名字。 注意 EquilateralTriangle 类的构造器执行了三步:
         1. 设置子类声明的属性值
         2. 调用父类的构造器
         3. 改变父类定义的属性值。其他的工作比如调用方法、getters 和 setters 也可以在这个阶段完成。
         如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用 willSet 和 didSet 。
         */
        
        //处理变量的可选值时，你可以在操作(比如方法、属性和子脚本)之前加 ? 。如果 ? 之前的值是 nil ， ? 后面 的东西都会被忽略，并且整个表达式返回 nil 。否则， ? 之后的东西都会被运行。在这两种情况下，整个表达式 的值也是一个可选值。
        
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
        _ = optionalSquare?.sideLength
        
        
        // 枚举和结构体
        let ace = Rank.Ace
        let aceRawValue = ace.rawValue
        //默认情况下，Swift 按照从 0 开始每次加 1 的方式为原始值进行赋值，不过你可以通过显式赋值进行改变。在 上面的例子中， Ace 被显式赋值为 1，并且剩下的原始值会按照顺序赋值。你也可以使用字符串或者浮点数作为 枚举的原始值。使用 rawValue 属性来访问一个枚举成员的原始值。

        //使用 init?(rawValue:) 初始化构造器在原始值和枚举值之间进行转换。
        if let convertedRank = Rank(rawValue: 3) {
            let threeDescription = convertedRank.simpleDescription()
            
            debugPrint("aceRawValue == \(aceRawValue),threeDescription == \(threeDescription)")
        }
        
        //枚举的成员值是实际值，并不是原始值的另一种表达方法。实际上，如果没有比较有意义的原始值，你就不需要
        //提供原始值。
        enum Suit {
            case Spades, Hearts, Diamonds, Clubs
            func simpleDescription() -> String {
                switch self {
                case .Spades:
                    return "spades"
                case .Hearts:
                    return "hearts"
                case .Diamonds:
                    return "diamonds"
                case .Clubs:
                    return "clubs"
                }
            }
        }
        let hearts = Suit.Hearts
        _ = hearts.simpleDescription()
//        let heartsValue = hearts.rawValue 这个会编译报错
        
        /*
         注意，有两种方式可以引用 Hearts 成员:给 hearts 常量赋值时，枚举成员 Suit.Hearts 需要用全名来引用，因 为常量没有显式指定类型。在 switch 里，枚举成员使用缩写 .Hearts 来引用，因为 self 的值已经知道是一个 suit 。已知变量类型的情况下你可以使用缩写。
         */
        
        //使用 struct 来创建一个结构体。结构体和类有很多相同的地方，比如方法和构造器。它们之间最大的一个区别就 是结构体是传值，类是传引用。
        struct Card {
            var rank: Rank
            var suit: Suit
            func simpleDescription() -> String {
                return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
            }
        }
        let threeOfSpades = Card.init(rank: .Three, suit: .Spades)
        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
        debugPrint("threeOfSpadesDescription == \(threeOfSpadesDescription)")
        
        /*
         一个枚举成员的实例可以有实例值。相同枚举成员的实例可以有不同的值。创建实例的时候传入值即可。实例值
         和原始值是不同的:枚举成员的原始值对于所有实例都是相同的，而且你是在定义枚举的时候设置原始值。
         */
        enum ServerResponse {
            case Result(String, String)
            case Failure(String)
        }
        let success = ServerResponse.Result("6:00 am", "8:09 pm")
        _ = ServerResponse.Failure("Out of cheese.")
        
        switch success {
        case let .Result(sunrise, sunset):
            let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
            debugPrint("serverResponse == \(serverResponse)")
        case let .Failure(message):
            debugPrint("Failure...  \(message)")
        }
    }
    //属性的懒加载，第一次访问才会计算初始值，在Swift中懒加载的属性不一定就是对象类型，也可以是基本类型
    lazy var baseClass = BaseClass()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

