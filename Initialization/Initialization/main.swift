//
//  main.swift
//  Initialization
//
//  Created by sunarvr on 15/8/3.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====存储型属性的初始赋值
// 构造器
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
println("The default temperature is \(f.temperature)° Fahrenheit")

// 默认属性值
//struct Fahrenheit {
//    var temperature = 32.0
//}

//====定制化构造过程
// 构造参数
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
println("boilingPointOfWater: \(boilingPointOfWater.temperatureInCelsius); freezingPointOfWater: \(freezingPointOfWater.temperatureInCelsius)")


// 内部和外部参数名
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// 可选属性类型
//class SunveyQuestion {
//    var text: String
//    var response: String?
//    init(text: String) {
//        self.text = text
//    }
//    func ask() {
//        println(text)
//    }
//}
//
//let cheeseQuestion = SunveyQuestion(text: "Do you like cheese?")
//cheeseQuestion.ask()
//cheeseQuestion.response = "Yes, I do like cheese."

// 构造过程中常量属性的修改
class SunveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        println(text)
    }
    
}

let cheeseQuestion = SunveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."


//====默认构造器
//class ShoppingListItem {
//    var name: String?
//    var quantity = 1
//    var purchased = false
//}
//var item = ShoppingListItem()

// 结构体的逐一成员构造器
//struct Size {
//    var width = 0.0, height = 0.0
//}
//
//let twoByTwo = Size(width: 2.0, height: 2.0)

//====值类型的构造器代理
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x:4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
println("basicRect: \(basicRect.origin.x), \(basicRect.origin.y), originRect: \(originRect.origin.x), \(originRect.origin.y), centerRect: \(centerRect.origin.x), \(centerRect.origin.y)")


//====类的继承和构造过程

// 指定构造器和便利构造器
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

// 指定构造器
let nameMeat = Food(name: "Bacon")

// 便利构造器
let mysteryMeat = Food()


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [ShoppingListItem(),
                    ShoppingListItem(name: "Bacon"),
                    ShoppingListItem(name: "Eggs", quantity: 6),
                    ]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    println(item.description)
}


//====可失败构造器
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    println("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    println("The anonymous creature could not be initialized")
}

// 枚举类型的可失败构造器
//enum TemperatureUnit {
//    case Kelvin, Celsius, Fahrenheit
//    init?(symbol: Character) {
//        switch symbol {
//        case "K":
//            self = .Kelvin
//        case "C":
//            self = .Celsius
//        case "F":
//            self = .Fahrenheit
//        default:
//            return nil
//        }
//    }
//}
//
//let fahrenheitUnit = TemperatureUnit(symbol: "F")
//if fahrenheitUnit != nil {
//    println("This is a defined temperature unit, so initialization succeeded.")
//}
//
//let unknowUnit = TemperatureUnit(symbol: "X")
//if unknowUnit == nil {
//    println("This is not a defined temperature unit, so initialization failed.")
//}

// 带原始值的枚举类型的可失败构造器
enum TemperatureUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    println("This is a defined temperature unit, so initialization succeeded.")
}

let unknowUnit = TemperatureUnit(rawValue: "X")
if unknowUnit == nil {
    println("This is not a defined temperature unit, so initialization failed.")
}

//// 类的可失败构造器
//class Product {
//    let name: String!
//    init?(name: String) {
//        if name.isEmpty { return nil }
//        self.name = name
//    }
//}
//
//// 构造失败的传递
//class CartItem: Product {
//    let quantity: Int!
//    init?(name: String, quantity: Int) {
//        super.init(name: name)
//        if quantity < 1 { return nil }
//        self.quantity = quantity
//    }
//}
//

// 覆盖一个可失败构造器
class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


class AutomaticallyNameDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}



//====必要构造器

 /// 当子类覆盖基类的必要构造器时，必须在子类的构造器前同样添加required修饰符以确保当其它类继承该子类时，该构造器同为必要构造器。在覆盖基类的必要构造器时，不需要添加override修饰符
//class SomeSubclass: SomeClass {
//    required init() {
//        // 在这里添加子类必要构造器的实现代码
//    }
//}



//====通过闭包和函数来设置属性的默认值
struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
println(board.squareIsBlackAtRow(0, column: 1))
println(board.squareIsBlackAtRow(9, column: 9))






