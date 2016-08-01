//
//  main.swift
//  Enumeratrons
//
//  Created by sunarvr on 15/7/22.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====枚举语法(Enumeration Syntax)
enum SomeEnumeration {
    //成员值
    //该值可以是一个字符串，一个字符，或是一个整型值或浮点值
}

enum CompassPoint {
    case North
    case South
    case East
    case West
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Nepture
}

//给枚举类型起一个单数名字而不是复数名字
var directionToHead = CompassPoint.West
directionToHead = .East

//====匹配枚举值与Switch语句(Matching Enumeration Values with a Switch Statement)
directionToHead = .South
switch directionToHead {
case .North:
    println("Lots of Planets have a notch")
case .South:
    println("Watch out for penguins")
case .East:
    println("Where the sun rises")
case .West:
    println("Where the skies are blues")
}

let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    println("Mostly harmless")
default:
    println("Not a safe place for humans")
}


//====相关值(Associated Values)
enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 58570_14111, 3)
productBarcode = .QRCode("SFOISHDFJSFS")

switch productBarcode {
case .UPCA(let numberSystem, let identifier, let check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case .QRCode(let productCode):
    println("QR code with value of \(productCode).")
}

switch productBarcode {
case let .UPCA(numberSystem, identifier, check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case let .QRCode(productCode):
    println("QR code with value of \(productCode).")
}


//====原始值(Raw Values)
/**
*  枚举成员可以被默认值（称为原始值）预先填充，其中这些原始值具有相同的类型
*/
enum ASCIIContolCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

/**
*  原始值可以是字符串，字符，或者任何整型值或浮点型值。每个原始值在它的枚举声明中必须是唯一的。当整型值被用于原始值，如果其他枚举成员没有值时，它们会自动递增。
*/
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Urans, Neptune
}

let earthsOrder = Planet1.Earth.rawValue
println("earthsOrder: \(earthsOrder)")
println("Neptune: \(Planet1.Neptune.rawValue)")
println("Urans: \(Planet1.Urans.rawValue)")

let possiblePlanet = Planet1(rawValue: 7)
println(possiblePlanet)

let positionToFind = 9
if let somePlanet  = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        println("Mostly harmless")
    default:
        println("Not a safe place for humans")
    }
} else {
    println("There isn't a planet at position \(positionToFind)")
}


