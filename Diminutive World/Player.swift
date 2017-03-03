//
//  Player.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

enum Direction {
    case north
    case south
    case east
    case west
}

struct Position: Hashable {
    /*
     Position is represents a position on a 2D plane.
     */
    var x: Int = 0
    var y: Int = 0
    mutating func move(inDirection d: Direction) {
        /*
         */
        switch d {
        case Direction.north:
            self.y += 1
        case Direction.south:
            self.y -= 1
        case Direction.west:
            self.x -= 1
        case Direction.east:
            self.x += 1
        }
    }
    
    var hashValue: Int {
        return (self.x.hashValue ^ self.y.hashValue)
    }
    
    static func ==(p1: Position, p2: Position) -> Bool {
        return (p1.x == p2.x) && (p1.y == p2.y)
    }
}

class Player {
    let name: String
    var pos: Position
    
    init(called name: String, at pos: Position) {
        self.name = name
        self.pos = pos
    }
    
    convenience init(called name: String) {
        self.init(called: name, at: Position())
    }
    
    func go(inDirection d: Direction) {
        pos.move(inDirection: d);
    }
    
    func locationInfo(in language: String="English") -> String {
        switch language {
        case "English":
            return "\(name) is standing at <\(pos.x), \(pos.y)>"
        case "Japanese":
            return "\(name)は<\(pos.x), \(pos.y)>にいる"
        default:
            return "<\(pos.x), \(pos.y)>"
        }
    }
}
