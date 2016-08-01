//
//  main.swift
//  AutomaticReferenceCounting
//
//  Created by sunarvr on 15/8/3.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====自动引用计数的工作机制

//====自动引用计数实践
//class Person {
//    let name: String
//    init(name: String) {
//        self.name = name
//        println("\(name) is being initialized")
//    }
//    deinit {
//        println("\(name) is being deinitialized")
//    }
//}
//
//var reference1: Person?
//var reference2: Person?
//var reference3: Person?
//
//reference1 = Person(name: "John Appleseed")
//reference2 = reference1
//reference3 = reference1
//
//reference1 = nil
//reference2 = nil
//
//reference3 = nil

//====类实例之间的循环强引用
//class Person {
//    let name: String
//    init(name: String) { self.name = name }
//    var apartment: Apartment?
//    deinit { println("\(name) is being deinitialized") }
//}

//class Apartment {
//    let number: Int
//    init(number: Int) { self.number = number }
//    var tenant: Person?
//    deinit { println("Apartment #\(number) is being deinitialized") }
//}

//var john: Person?
//var number73: Apartment?
//
//john = Person(name: "John Appleseed")
//number73 = Apartment(number: 73)
//john!.apartment = number73
//number73!.tenant = john
//john = nil
//number73 = nil
//

//====解决实例之间的循环强引用
/**
*  Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
*
*   对于生命周期中会变为nil的实例使用弱引用。相反的，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。
*/


// 弱引用
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { println("\(name) is being deinitialized") }
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person?
    deinit { println("Apartment #\(number) is being deinitialized") }
}

var john: Person?
var number73: Apartment?

john = Person(name: "John Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john
john = nil
number73 = nil

// 无主引用
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { println("\(name) is being deinitialized") }
}

class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { println("Card #\(number) is being deinitialized") }
}

var tom: Customer?
tom = Customer(name: "Tom Appleseed")
tom!.card = CreditCard(number: 1234_5678_9012_3456, customer: tom!)
tom = nil

// 无主引用以及隐式解析可选属性
//class Country {
//    let name: String
//    let capitalCity: City!
//    init(name: String, capitalName: String) {
//        self.name = name
//        self.capitalCity = City(name: capitalName, country: self)
//    }
//}
//
//class City {
//    let name: String
//    unowned let country: Country
//    init(name: String, country: Country) {
//        self.name = name
//        self.country = country
//    }
//}


//====闭包引用的循环强引用
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        println("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello world")
println(paragraph!.asHTML())
paragraph = nil

//====解决闭包引起的循环强引用
/**
*  捕获列表中的每个元素都是由weak或者unowned关键字和实例的引用（如self或someInstance）成对组成。每一对都在方括号中，通过逗号分开。
*/
