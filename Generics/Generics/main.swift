//
//  main.swift
//  Generics
//
//  Created by sunarvr on 15/7/10.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation


func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt is now \(someInt), and antherInt is now \(anotherInt)")



func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someString = "你好"
var 🔥🔥 = "🔥🔥"
swapTwoValues(&someString, &🔥🔥)
//println("someString is now \(someString), and 🔥🔥 is now \(🔥🔥)")

/*
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
*/

/*
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T? {
        return items.isEmpty ? nil : items.removeLast()
    }
}


var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

println("stackOfStrings: \(stackOfStrings.items)")

let fromTheTop = stackOfStrings.pop()
stackOfStrings.pop()
stackOfStrings.pop()
stackOfStrings.pop()
stackOfStrings.pop()
println("fromTheTop:\(fromTheTop)")


//Extending a Generic Type
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count-1]
    }
}

if let topItem = stackOfStrings.topItem {
    println("The top item on the stack is \(topItem).")
}

//func someFunction<T: SomeClass, U: SomeProtocol> (someT: T, someU: U) {
//     
//}
*/

func findStringIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    println("The index of llama is \(foundIndex)")
}

let ints = [1, 2, 3, 4, 5]
if let foundIndex = findStringIndex(ints, 2) {
    println("The index of 2 is \(foundIndex)")
}


/*
① 下标语法使用subscript关键字来定义
② 下标语法使用get、set来定义读、写属性，并不需要2个属性都有，可以只读
③ 定义set属性时，传入的参数默认名称为newValue。并且newValue的类型和subscript函数返回值相同
*/

protocol Container {
    typealias ItemType // typealias 类型别名
    mutating func append(item: ItemType) // 为了能够在实例方法中修改属性值，可以在方法定义前添加关键字mutating
    var count: Int { get } //只需要读方法
    subscript(i: Int) -> ItemType { get } //新添加的ItemType 的下标

}


struct IntStack: Container {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct  Stack<T>: Container {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func append(item: T) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> T {
        return items[i]
    }
}

extension Array: Container {}


// <> 参数类型。    : 需要遵守的协议。   where关键字：条件。
func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer: C1, anotherContainer: C2) -> Bool {
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}

var stackOfStrings1 = Stack<String>()
stackOfStrings1.push("uno")
stackOfStrings1.push("dos")
stackOfStrings1.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings1, arrayOfStrings) {
    println("All items match.")
} else {
    println("Not all items match.")
}



