//
//  main.swift
//  Protocols
//
//  Created by sunarvr on 15/8/7.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====协议的语法(Protocol Syntax)
protocol SomeProtocol {
    
}

struct SomeStructure: SomeProtocol {
    
}

class SomeClass: SomeProtocol {
    
}

//====对属性的规定(Poperty Requirements)
protocol AnotherProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol FirstProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
println("ncc1701: \(ncc1701.fullName)")

//====对方法的规定(Method Requirements)

/**
*  在协议的方法定义中，不支持参数默认值。
*/

protocol MyProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
println("Here's a random number: \(generator.random())")
println("And another one: \(generator.random())")


//====对Mutating方法的规定(Mutating Method Requirements)

/**
*  用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
*/
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

//====对构造器的规定(Initializer Requirements)
// 协议构造器规定在类中的实现
//class SomeClass: SomeProtocol {
//    required init(someParameter: Int) {
//        //构造器实现
//    }
//}

//protocol SomeProtocol {
//    init()
//}
//
//class SomeSuperClass {
//    init() {
//        // 构造器的实现
//    }
//}
//
//class SomeSubClass: SomeSuperClass, SomeProtocol {
//    required override init() {
//        
//    }
//}

// 可失败构造器的规定




//====协议类型(Protocols as Types)
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    println("Random dice roll is \(d6.roll())")
}

//====委托（代理）模式(Delegation)
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAsLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAsLadders {
            println("Started a new game of Snakes and Ladders")
        }
        println("The game is using a \(game.dice.sides)-sided dice")
    }

    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        ++numberOfTurns
        println("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        println("The game lasted for \(numberOfTurns) turns")
    }
    
}

let tracker = DiceGameTracker()
let game = SnakesAsLadders()
game.delegate = tracker
game.play()

//====在扩展中添加协议成员(Adding Protocol Conformance with an Extension)
protocol TextRepresentable {
    func asText() -> String
}

extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}

extension SnakesAsLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes ande Ladders with \(finalSquare) squares"
    }
}
println(game.asText())

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())

//====通过扩展补充协议声明(Declaring Protocol Adoption with an Extension)

/**
*  当一个类型已经实现了协议中的所有要求，却没有声明为遵循该协议时，可以通过扩展(空的扩展体)来补充协议声明
*/
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
println(somethingTextRepresentable.asText())

//====集合中的协议类型(Collections of Protocol Types)
let things: [TextRepresentable] = [game,d12,simonTheHamster]
for thing in things {
    println(thing.asText())
}

//====协议的继承(Protocol Inheritance)
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}

protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}

extension SnakesAsLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

println(game.asPrettyText())

//====类专属协议(Class-Only Protocol)
/**
*  你可以在协议的继承列表中,通过添加class关键字,限制协议只能适配到类（class）类型。（结构体或枚举不能遵循该协议）。该class关键字必须是第一个出现在协议的继承列表中，其后，才是其他继承协议。
*/
protocol SomeClassOnlyProtocol: class, InheritingProtocol {
    
}

//====协议合成(Protocol Composition)
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person1: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    println("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)


//====检验协议的一致性(Checking for Protocol Conformance)
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.01415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        println("Area is \(objectWithArea.area)")
    } else {
        println("Something that doesn't have an area")
    }
}

//====对可选协议的规定(Optional Protocol Requirements)
/**
*   可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循
    这个前缀表示协议将暴露给Objective-C代码，详情参见Using Swift with Cocoa and Objective-C。即使你不打算和Objective-C有什么交互，如果你想要指明协议包含可选属性，那么还是要加上@obj前缀
*/

@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}


@objc class Counter {
    var count: Int = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement { // else if let amount = dataSource?.fixedIncrement?（书）
            count += amount
        }
    }
}

@objc class ThreeSource: CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
//counter.dataSource = ThreeSource()
//for _ in 1...4 {
//    counter.increment()
//    println(counter.count)
//}

@objc class TowardsZeroSource: CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    println(counter.count)
}



//====协议扩展(Protocol Extensions)  // swift2.0
//extension RandomNumberGenerator {
//    func randomBool() -> Bool {
//        return random() > 0.5
//    }
//}
//



