//
//  main.swift
//  Classes&Structures
//
//  Created by sunarvr on 15/7/22.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====类和结构体对比(Comparing Classes and Structures)
//定义
class SomeClass {
    
}

struct SomeStruct {
    
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


//类和结构体实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

//属性访问
println("The width of someResolution is \(someResolution.width)")
println("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
println("The width of someResolution is \(someResolution.width)")
println("The width of someVideoMode is \(someVideoMode.resolution.width)")


//结构体类型的成员逐一构造器(Memberwise Initializers for structure Types)
let vga = Resolution(width: 640, height: 480)


//====结构体和枚举是值类型(Structures and Enumerations Are Value Types)
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
println("cinema is now \(cinema.width) pixels wide")
println("hd is still \(hd.width) pixels wide")

//枚举也遵循相同的行为准则
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
var rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    println("The remembered direction is still .West")
}


//====类是引用类型(Classes Are Reference Types)

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
println("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

//恒等运算符
if tenEighty === alsoTenEighty {
    println("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}

//指针
/**
*  如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一个 Swift 常量或者变量引用一个引用类型的实例与 C 语言中的指针类似，不同的是并不直接指向内存中的某个地址，而且也不要求你使用星号（*）来表明你在创建一个引用。Swift 中这些引用与其它的常量或变量的定义方式相同。
*
*/


//====类和结构体的选择(Choosing Between Classes and Structures)
/**
*   结构体的主要目的是用来封装少量相关简单数据值。
    有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
    任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
    结构体不需要去继承另一个已存在类型的属性或者行为。
*/

//====集合类型的赋值与复制行为(Assignment and Copy Behavior for Strings,Arrays,and Dictionaries)

