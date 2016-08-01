//
//  main.swift
//  Properties
//
//  Created by sunarvr on 15/7/22.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

/**
*  计算属性计算（而不是存储）一个值。计算属性可以用于类、结构体和枚举里，存储属性只能用于类和结构体。
*/

//====存储属性(Stored Properties)
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//常量和存储属性
let rangeOfFourTtems = FixedLengthRange(firstValue: 0, length: 4)
/**
*  这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
*/
//rangeOfFourTtems.firstValue = 6 // 报错

//延迟存储属性
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
println(manager.data) // DataImporter 实例的 importer 属性还没有被创建

println(manager.importer.fileName) // DataImporter 实例的 importer 属性现在被创建了


//====计算属性(Computed Properties)
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
println("initialSquareCenter: (\(initialSquareCenter.x), \(initialSquareCenter.y))")
println("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//便捷setter声明
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//只读计算属性
struct Cuboid {
    var width = 0.0, heigth = 0.0, depth = 0.0
    var volume: Double {
        return width * heigth * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, heigth: 5.0, depth: 2.0)
println("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")


//====属性观察器(Property Observers)
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            println("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                println("Added \(totalSteps - oldValue) steps")
//                totalSteps = 102
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896



//====全局变量和局部变量(Global and Local Variables)






//====类型属性(Type Properties)

//类型属性语法
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
//        return self.computedTypeProperty
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
//        return self.computedTypeProperty
        return 1
    }
}


class SomeClass {
    class var computedTypeProperty: Int {
        return 1
    }
}

//获取和设置类型属性的值

/**
*  使用关键字static来定义值类型的类型属性，关键字class来为类（class）定义类型属性。
*/
var someEnumeration = SomeEnumeration.computedTypeProperty
println(someEnumeration)

println(SomeClass.computedTypeProperty)
println(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
println(SomeStructure.storedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChnanel = AudioChannel()

leftChannel.currentLevel = 7
println(leftChannel.currentLevel)
println(AudioChannel.maxInputLevelForAllChannels) // 类型属性是通过类型本身来获取和设置，而不是通过实例


