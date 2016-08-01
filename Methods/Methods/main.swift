//
//  main.swift
//  Methods
//
//  Created by sunarvr on 15/7/15.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation


class Counter {
    var count: Int = 0
    func incrementBy(#amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter = Counter()
//counter.incrementBy(5, numberOfTimes: 3)
//counter.incrementBy(<#amount: Int#>, numberOfTimes: <#Int#>)
//struct Point {
//    var x = 0.0, y = 0.0;
//    func isToTheRightOfX(x: Double) -> Bool {
//        println("self.x:\(self.x), x:\(x)")
//        return self.x > x
//    }
//}
//
//let somePoint = Point(x: 4.0, y: 5.0)
//if somePoint.isToTheRightOfX(1.0) {
//    println(" kjk")
//}

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
println("x: \(somePoint.x), y: \(somePoint.y)")


enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
            case Off:
                self = Low
            case Low:
                self = High
            case High:
                self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


var levelTracker = LevelTracker.levelIsUnlocked(3)
println(levelTracker)

LevelTracker.unlockLevel(5)
println(LevelTracker.levelIsUnlocked(3))



var tracker = LevelTracker()
var isLevel = tracker.advanceToLevel(7)
println("7 isLevel:\(isLevel)")


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completeLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completeLevel(6)
println("now: \(LevelTracker.highestUnlockedLevel)")


struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
println("six times three is \(threeTimesTable[6])")

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
println("\(numberOfLegs)")

numberOfLegs["bird"] = nil
println("\(numberOfLegs)")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
    
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)

println(matrix.grid)
if matrix.indexIsValidForRow(2, column: 2) {
    let someValue = matrix[2, 2];
    println("someValue:\(someValue)")

}

/**
    枚举

*/
enum SomeEnumeration {
    case North
    case South
    case East
    case West
}

var directionToHead = SomeEnumeration.West
directionToHead = .East

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(9, 25214_12111, 3)
productBarcode = .QRCode("KFJDSKFJLS")

switch productBarcode {
case .UPCA(let numberSystem, let identifier, let check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case .QRCode(let productCode):
    println("QR code with value of \(productCode).")
}

//switch productBarcode {
//    case let .UPCA
//}



/**
*  Inheritance 继承
*/
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


class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
println("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
println("Tandem: \(tandem.description)")


class Train: Vehicle {
    override func makeNoise() {
        println("Choo Choo")
    }
}

let train = Train()
train.makeNoise()


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








