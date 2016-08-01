//
//  main.swift
//  Inheritance
//
//  Created by sunarvr on 15/8/3.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====定义一个基类(Base class)
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
println("Vehicle: \(someVehicle.description)")


//====子类生成(Subclassing)
class Bicyle: Vehicle {
    var hasBasket = false
}

let bicyle = Bicyle()
bicyle.hasBasket = true
bicyle.currentSpeed = 15.0
println("Bicyle: \(bicyle.description)")

class Tandem: Bicyle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
println("Tandem: \(tandem.description)")

//====重写(Overriding)

// 访问超类的方法，属性及下标脚本
/**
*  在合适的地方，你可以通过使用super前缀来访问超类版本的方法，属性或下标脚本
*/


// 重写方法
class Train: Vehicle {
    override func makeNoise() {
        println("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

// 重写属性

// 1. 重写属性的Getters和Setters
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
println("Car: \(car.description)")

// 2. 重写属性观察器(Property Observer)
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
println("AutomaticCar: \(automatic.description)")

//====防止重写
/**
*  你可以通过把方法，属性或下标脚本标记为final来防止它们被重写，只需要在声明关键字前加上final特性即可。
*/









