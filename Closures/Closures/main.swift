//
//  main.swift
//  Closures
//
//  Created by sunarvr on 15/7/22.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation


//====闭包表达式(Closure Expressions)

// sort函数
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}


var reversed = sorted(names, { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

reversed = sorted(names, { (s1: String, s2: String) -> Bool in return s1 > s2} )

println(reversed)

//根据上下文推断类型(Inferring Type From Context)
reversed = sorted(names, {s1, s2 in return s1 > s2} )

//单表达式闭包隐式返回(Implicit Return From Single-Expression Clossures)
reversed = sorted(names, {s1, s2 in s1 > s2} )

//参数名称缩写(Shorthand Argument Names)
reversed = sorted(names, {$0 > $1} ) //上面还需定义s1, s2 所以包含关键字in 这个已经只有闭包函数体，所以in也可以省略

//运算符函数(Operator Functions)
reversed = sorted(names, >)


//====尾随闭包(Trailing Closures)
func someFunctionThatTakesAClosure(closure: () -> ()) {
    
}

someFunctionThatTakesAClosure({
    //不使用尾随闭包进行函数调用
})

someFunctionThatTakesAClosure() {
    //使用尾随闭包进行函数调用
}

reversed = sorted(names) { $0 > $1 }


let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

//不使用尾随闭包进行函数调用
let strings1 = numbers.map({
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
})

println(strings)
println("strings1 is \(strings1)")


//====捕获值(Capturing Values)
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()  // 10
println(incrementByTen()) // 20


//****循环引用
/**
*  注意： 如果您将闭包赋值给一个类实例的属性，并且该闭包通过指向该实例或其成员来捕获了该实例，您将创建一个在闭包和实例间的强引用环。 Swift 使用捕获列表来打破这种强引用环。更多信息，请参考 闭包引起的循环强引用。
*/

//====闭包是引用类型(Clousures Are Reference Type)

//将闭包赋值给了两个不同的常量/变量，两个值都会指向同一个闭包
let alsoIncrementByTen = incrementByTen
println(incrementByTen()) // 30


