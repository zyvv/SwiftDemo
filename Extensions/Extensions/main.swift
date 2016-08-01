//
//  main.swift
//  Extensions
//
//  Created by sunarvr on 15/8/6.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====扩展语法(Extension Syntax)

/**
*   添加计算型属性和计算型静态属性
    定义实例方法和类型方法
    提供新的构造器
    定义下标
    定义和使用新的嵌套类型
    使一个已有类型符合某个协议
*/

//extension SomeType {
//    
//}

//extension SomeType: SomeType: SomeProtocol, AnotherProctocol {
//    
//}

//====计算型属性(Computed Properties)
extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
println("One inch is \(oneInch) meters")

let threeFeet = 3.ft
println("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
println("A marathon is \(aMarathon) meters long")

//====构造器(Initializers)

/**
*  扩展能向类中添加新的便利构造器，但是它们不能向类中添加新的指定构造器或析构器。
*/

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

/**
*  如果你使用扩展向一个值类型添加一个构造器，在该值类型已经向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers）时，你可以在值类型的扩展构造器中调用默认构造器(default initializers)和逐一成员构造器(memberwise initializers)。
*/
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size) // 逐一构造器
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//====方法(Methods)

extension Int {
    func repetitions(task: () -> ()) {
        for i in 0..<self {
            task()
        }
    }
}

3.repetitions({
    println("Hello!")
})

3.repetitions{
    println("Goodbye!")
}


// 修改实例方法(Mutating Instance Methods)
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
println("someInt.square \(someInt)")


//====下标(Mutating Instance Methods)
extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}

println("\(746381295[0]), \(746381295[1]), \(746381295[2]), \(746381295[8]) ")


//====嵌套类型(Nested Types)
extension Int {
    enum Kind {
        case Negative, Zero, Position
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Position
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            println("- ", appendNewline: false)
        case .Position:
            println("+ ", appendNewline: false)
        case .Zero:
            println("0 ", appendNewline: false)
        }
    }
//    println("")
}
printIntegerKinds([3, 19, -17, 0, -6, 0, 7])



