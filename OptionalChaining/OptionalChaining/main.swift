//
//  main.swift
//  OptionalChaining
//
//  Created by sunarvr on 15/8/5.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====可选链可替代强制解析

// 使用可空链式调用来强制展开
class Person {
    var residence: Residence?
}

/*
class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
}else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
}else {
    print("Unable to retrieve the number of rooms.")
}
*/

// 为可空链式调用定义模型类
class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

// 通过可空链式调用访问属性
let john = Person()
//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) room(s).")
//} else {
//    print("Unable to retrieve the number of rooms.")
//}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

if let roomCount = john.residence?.address {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

// 通过可空链式调用来访问下标
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the frist room name.")
}

john.residence?[0] = Room(name: "Bathroom")

let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Living Room"))
johnHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

// 访问可空类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72

// 多层链接 (此时 residence已不为nil)
let johnAddress = Address()
johnAddress.buildingName = "The Larches"
johnAddress.street = "Laurel Street"
john.residence?.address = johnAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

// 对返回值可空值的函数进行链接
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}





