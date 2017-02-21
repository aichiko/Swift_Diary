//
//  GIFViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/2/9.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import UIKit
import WebKit
import ImageIO
import MobileCoreServices

//下面例子定义了一个 Container 协议，该协议定义了一个关联类型 ItemType :
protocol StackContainer {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) ->ItemType { get }
}

//下面展示了如何编写一个非泛型版本的栈，以 Int 型的栈为例:
struct Int_Stack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//下面是相同代码的泛型版本:
//你也可以让泛型 Stack 结构体遵从 Container 协议:
struct item_Stack<Element>: StackContainer {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    //typealias ItemType = Element
    //由于 Swift 的类型推断，你实际上不用在 IntStack 的定义中声明 ItemType 为 Element 。
    
    mutating func append(item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//下面的例子扩展了泛型类型 Stack ，为其添加了一个名为 topItem 的只读计算型属性，它将会返回当前栈顶端 的元素而不会将其从栈中移除:
extension item_Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

class GIFViewController: UIViewController {

    lazy var webview: WKWebView = WKWebView.init()
    
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "关于GIF"
        
        //虽然是关于GIF的，但是首先介绍一下swift的泛型，泛型是 Swift 最强大的特性之一。
        
        var someInt = 3
        var anotherInt = 107
        swapTwoValues(&someInt, &anotherInt)
        // someInt is now 107, and anotherInt is now 3
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        // someString is now "world", and anotherString is now "hello"
        print("someString is now \(someString), and anotherString is now \(anotherString)")
        //泛型函数会自动判断T的属性，当然也可以直接定义T的属性
        
        //泛型类型
        //除了泛型函数，Swift 还允许你定义泛型类型。这些自定义类、结构体和枚举可以适用于任何类型，类似于 Array和 Dictionary。
        //你可以通过在尖括号中写出栈中需要存储的数据类型来创建并初始化一个 Stack 实例。例如，要创建一个 ing 类型的栈，可以写成 Stack<String>()
        var stackOfStrings = item_Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        
        let fromTheTop = stackOfStrings.pop()
        // fromTheTop 的值为 "cuatro"，现在栈中还有 3 个字符串
        print("fromTheTop === \(fromTheTop)")
        
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem).")
        }
        // 打印 “The top item on the stack is tres.”
        
        // MARK: - webview
        //关于gif
        //1.使用webview来显示GIF
        /*
        self.view.addSubview(webview)
        webview.frame = self.view.bounds
        
        let path = Bundle.main.path(forResource: "timg", ofType: "gif")
        if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path!)) {
            webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: Bundle.main.resourceURL!)
        }
        
        //当然也可以直接加载文件路径,下面两种load方法都可以实现
        webview.load(URLRequest.init(url: URL.init(fileURLWithPath: path!)))
        webview.loadFileURL(URL.init(fileURLWithPath: path!), allowingReadAccessTo: Bundle.main.resourceURL!)
        */
        
        let (images, duration) = showGif()!
//        let animatedImage = UIImage.animatedImage(with: images, duration: duration)
        imageView = UIImageView.init(image: images.first)
        
        self.view.addSubview(imageView!)
        imageView?.center = self.view.center
        
        imageView?.animationImages = images
        imageView?.animationDuration = duration
        imageView?.animationRepeatCount = 3
        imageView?.startAnimating()
    }

    //每个参数的类型都要标明，因为它们不能被推断出来。如果您在某个参数类型前面加上了 inout ，那么这个参数 就可以在这个函数作用域当中被修改。
    //交换a b 的值
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //类型约束语法
    //你可以在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，它们将成为类型
    //参数列表的一部分。对泛型函数添加类型约束的基本语法如下所示(作用于泛型类型时的语法与之相同):
    /*
    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) { // 这里是泛型函数的函数体部分
        
    }
     */
    
    func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    // MARK: - ImageIO
    private func showGif() ->([UIImage], TimeInterval)? {
        let path = Bundle.main.path(forResource: "timg", ofType: "gif")
        let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path!))
        let source = CGImageSourceCreateWithData(data as! CFData, nil)
        let count = CGImageSourceGetCount(source!)
        let options: NSDictionary = [kCGImageSourceShouldCache as String: true, kCGImageSourceTypeIdentifierHint as String: kUTTypeGIF]
        var gifDuration = 0.0
        var images = [UIImage]()
        
        func frameDuration(from gifInfo: NSDictionary) -> Double {
            let gifDefaultFrameDuration = 0.100
            let unclampedDelayTime = gifInfo[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber
            let delayTime = gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber
            let duration = unclampedDelayTime ?? delayTime
            guard let frameDuration = duration else { return gifDefaultFrameDuration }
            
            return frameDuration.doubleValue > 0.011 ? frameDuration.doubleValue : gifDefaultFrameDuration
        }
        for i in 0 ..< count {
            guard let imageRef = CGImageSourceCreateImageAtIndex(source!, i, options) else {
                return nil
            }
            if count == 1 {
                //只有一张图片时
                gifDuration = Double.infinity//无穷大
            }else {
                // Animated GIF
                guard let properties = CGImageSourceCopyPropertiesAtIndex(source!, i, nil), let gifinfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary  else {
                    return nil
                }
                gifDuration += frameDuration(from: gifinfo)
            }
            images.append(UIImage.init(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up))
        }
        
        return (images, gifDuration)
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
