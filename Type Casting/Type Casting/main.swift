//
//  main.swift
//  Type Casting
//
//  Created by sunarvr on 15/8/6.
//  Copyright (c) 2015年 com.sunarvr. All rights reserved.
//

import Foundation

//====定义一个类层次作为例子(Defining a Class Hierarchy for Type Casting)
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//====检查类型(Checking Type)
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        ++movieCount
    } else if item is Song {
        ++songCount
    }
}

println("Media library contains \(movieCount) movies and \(songCount) songs")

//====向下转型(Downcasting)
for item in library {
    if let movie = item as? Movie {
        println("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        println("Song: '\(song.name)', by \(song.artist)")
    }
}


//====Any和AnyObject的类型转换(Type Casting for Any and AnyObject)

/**
*  AnyObject可以代表任何class类型的实例。
*  Any可以表示任何类型，包括方法类型（function types）。
*/

// AnyObject类型
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

for object in someObjects {
    let movie = object as! Movie
    println("Movie:'\(movie.name)', dir. \(movie.director)")
}

for movie in someObjects as! [Movie] {
    println("Movie: '\(movie.name)', dir. \(movie.director)")
}

// Any类型
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        println("zero as an Int")
    case 0 as Double:
        println("zero as a Double")
    case let someInt as Int:
        println("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        println("a positive double value of \(someDouble)")
    case is Double:
        println("some other double value that I don't want to print")
    case let someString as String:
        println("a string value of \(someString)")
    case let (x, y) as (Double, Double):
        println("an(x, y) point at \(x), \(y)")
    case let movie as Movie:
        println("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String:
        println(stringConverter("Michael"))
    default:
        println("something else")
    }
}



