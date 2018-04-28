//: Playground - noun: a place where people can play

import UIKit



/** 可选值 */
func optionalTest() {
    let optionalString: String? = "Hello"
    print(optionalString == nil)
    
    let optionalName: String? = "John Appleseed"
    var greeting = "Hello"
    if let name = optionalName {
        greeting = greeting + name
    }
}

//optionalTest()

/** 循环 */
func circulationTest() {
    let array: Array = [1, 2, 4, 525, 114]
    
    for count in array {
        if count > 50 {
            print(count)
        }
    }
}

//circulationTest()

/// 多参数
func someFunction(first: Int, section: Int = 5) -> Int{
    let sum = first + section
    return sum
}

someFunction(first: 5, section: 4)

/// 可变参数
func changeableFunc(params: Int...) -> Int {
    
    var total: Int = 0
    for obj in params {
        total += obj
    }
    return total
    
}

changeableFunc(params: 1, 2, 5)

/// 输入输出参数
func swapTwoInt(_ a: inout Int, _ b: inout Int){
    let temp = a
    a = b
    b = temp
}

var one = 5
var two = 3
swapTwoInt(&one, &two)
print(one, two)



/// Closure闭包函数
func closure() {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    
    /** 闭包表达式基本语法 */
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    let x = names.sorted(by: backward)
    print(x)
    
    let y = names.sorted { (s1: String, s2: String) -> Bool in
        return s1 > s2
    }
    print(y)
    
    /** 根据上下文推断类型 */
    let z = names.sorted(by: { s1, s2 in return s1 > s2 })
    print(z)
    
    /** 单表达式闭包隐式返回 */
    let m = names.sorted(by: {s1, s2 in s1 > s2})
    print(m)
    
    /** 参数名称缩写
        Swift自动为内联闭包提供了参数名称缩写功能，可直接通过$0,$1,$2来顺序调用闭包的参数，以此类推。
        如果在闭包表达式中使用参数名称缩写，可以再闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。'in'关键字同样可以被省略，因为此时闭包表达式完全由闭包函数体构成。
     */
    let n = names.sorted(by: {$0 > $1})
    print(n)
    
    /** 运算符方法 */
    let a = names.sorted(by: >)
    print(a)
    
    /** 尾随闭包 
        如果需要经一个很长的闭包表达式座位最后要一个参数传递给函数，可以是用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签
     */
    func someFunctionClosure(closure: () -> Void) {
        // 函数体部分
    }
    
    // 不使用尾随闭包进行函数调用
    someFunctionClosure(closure: {
        // 闭包主体部分
    })
    
    // 使用尾随闭包进行函数调用, 如果闭包表达式是函数或方法的唯一参数，则当使用尾随闭包时,你甚至可以把'()'省略
    someFunctionClosure() {
        // 闭包主体部分
    }
    
    
    /** Map */
    let digitNames: Dictionary = [0: "Zero",
                                  1: "One",
                                  2: "Two",
                                  3: "Three",
                                  4: "Four",
                                  5: "Five",
                                  6: "Six",
                                  7: "Seven",
                                  8: "Eight",
                                  9: "Nine"]
    let numbers = [23, 64, 215]
    let strings: Array = numbers.map { (number) -> String in
        var number = number
        var output = ""
        repeat {
            output = digitNames[number % 10]! + output
            number /= 10
            print(number)
        } while number > 0
        return output
    }
    print(strings)
    
    
    /** 闭包的值捕获 */
    
}

closure()



func setTest() {
    
    if #available(iOS 10, *) {
        print("The above iOS 10 version ")
    } else {
        print("The following iOS 10 version ")
    }
    
    var integerValue: Int?
    guard integerValue != nil else {
        print("并没有")
        return
    }
    print("我就看怎么才能走道这一步")
    
    var x = 0, y = 10, z = 0
    
    gameLoop: while x != y {
        x += 1
        
        switch x {
            
        case 2...4:
            continue gameLoop
        default:
             z = x
             print(z)
        }
    }
    print(z)
    
    
    
    for index in 1...5 {
        
        var isFind: Bool = false
        
        switch index {
        case 3:
            isFind = true
            break
        default:
            isFind = false
            
            print(index)
        }
        
        if isFind {
            break
        }
    }
    
}

//setTest()




/** 三门问题 */
/** 参赛者会看见三扇关闭了的门，其中一扇的后面有一辆汽车，选中后面有车的那扇门可赢得该汽车，另外两扇门后面则各藏有一只山羊。当参赛者选定了一扇门，但未去开启它的时候，节目主持人开启剩下两扇门的其中一扇，露出其中一只山羊。主持人其后会问参赛者要不要换另一扇仍然关上的门。问题是：换另一扇门会否增加参赛者赢得汽车的机率
 **/
func threeDoorQuestion() {

    var 中奖: Int = 0
    
    var i = 10000
    
    while i > 0 {
        let carIndex = (Int)(arc4random() % 3)
        
        var threeDoor: Array<String> = ["🐑", "🐑", "🐑"]
        threeDoor[carIndex] = "🚘"
        
        let chooseIndex = (Int)(arc4random() % 3)
        threeDoor.remove(at: chooseIndex)
        
        for i in 0 ..< threeDoor.count {
            if threeDoor[i] == "🐑" {
                threeDoor.remove(at: i)
                break;
            }
        }
        
        if threeDoor[0] == "🚘" {
            中奖 += 1
        }
        i -= 1
    }
    
    print(中奖)
}

//threeDoorQuestion()


/**
 双信封悖论问题:
 现在有信封A和B，它们里面都装着钱，其中一个的数量是另一个的两倍。
 现在让你任挑一个信封，把里面的钱拿走。但在选择之前，我们不知道信
 封里的钱是多少。 现在你选择了信封A，打开一看，里面有100块。现在
 有机会让你改选B，你改不改选？
 因为B可能有200块，也可能有50块，它们的可能性都是50%。那么B的期
 望值是200 x 50% + 50 x 50% = 125，比A的100元多。所以应该改选？
 */
/// 样本空间已确定
func twoEnvelopQuestion1() {
    
    var noChange = 0
    var change = 0
    var i = 10000
    
    while i > 0 {
        let x = (Int)(arc4random() % 2)
        let a = x == 1 ? 2 : 1
        let b = x == 1 ? 1 : 2
        
        let twoEnvelop: Array <Int> = [a, b]
        
        let chooseIndex = (Int)(arc4random() % 2)
        let noChooseIndex = chooseIndex == 0 ? 1 : 0
        
        noChange += twoEnvelop[chooseIndex]
        change += twoEnvelop[noChooseIndex]
        
        i -= 1
    }
    
    print(noChange)
    print(change)
}
twoEnvelopQuestion1()

/// 样本空间未确定
func twoEnvelopQuestion2() {
    
    /// 4表示4X，
    /** 
     悖论问题点:
     从纯逻辑来说，从0到无穷大中随机取一个数，这个数应该100%是无穷大
     1 + ∞ = ∞
     2 + ∞ = ∞
     1 == 2 ?
     */
    
    var noChange = 0
    var change = 0
    var i = 1000
    while i > 0 {
        let r = (Int)(arc4random() % 2)
        let a = 4
        let b = r == 1 ? a * 2 : a / 2
        
        noChange += a
        change += b
        i -= 1
    }
    print(noChange)
    print(change)
}

twoEnvelopQuestion2()

