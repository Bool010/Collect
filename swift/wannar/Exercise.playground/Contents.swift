//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///////////////// Map //////////////////
func map() {
    let a = [[1, 2, 3], [4, 5, 6]]
    _ = a.map { (x) -> [Int] in
        x.map({ (y) -> Int in
            y + 1
        })
    }
    
    _ = a.flatMap { (x) -> [Int] in
        x.flatMap({ (y) -> Int in
            y
        })
    }
    
    _ = a.flatMap { (x) -> [Int]? in
        x.flatMap({ (y) -> Int in
            y
        })
    }
}
map()



///////////////// Filter //////////////////
func filter() {
    let a = ["hello", "world", "this"]
    _ = a.filter { (str) -> Bool in
        str.characters.count == 4
    }
}
filter()



//////////////// Reduce ///////////////////
func reduce() {
    let a = ["hello", "world", "this"]
    _ = a.reduce("a") { (p, str) -> String in
        p + str
    }
}
reduce()


