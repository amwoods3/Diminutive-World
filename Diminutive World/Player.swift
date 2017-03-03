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
            self.y -= 1
        case Direction.south:
            self.y += 1
        case Direction.west:
            self.x -= 1
        case Direction.east:
            self.x += 1
        }
    }
    
    func get_pos(inDirection d: Direction) -> Position {
        var pos = Position(x: self.x, y: self.y)
        pos.move(inDirection: d)
        return pos
    }
    var hashValue: Int {
        return (self.x.hashValue ^ self.y.hashValue)
    }
    
    static func ==(p1: Position, p2: Position) -> Bool {
        return (p1.x == p2.x) && (p1.y == p2.y)
    }
}

let playerSymbol = Character("@")
let startingRoom = "starterRoom"
let startingPosition = Position(x: 5, y: 5)

class Player {
    let name: String
    var pos: Position
    var room: Room
    var facing: Direction
    var money: Int
    
    init(called name: String, at pos: Position, in room: String, money: Int) {
        self.name = name
        self.pos = pos
        self.room = loadRoom(called: room)
        self.facing = Direction.north
        self.money = money
    }
    
    convenience init(called name: String) {
        self.init(called: name, at: startingPosition, in: startingRoom, money: 0)
    }
    
    func go(inDirection d: Direction) {
        if check(inDirection: d) {
            // move player if spot can be stood in
            pos.move(inDirection: d);
            self.facing = d
        } else {
            print("can't go there!")
        }
    }
    
    func check(inDirection d: Direction) -> Bool {
        return self.room[self.pos.get_pos(inDirection: d)].can_go_through
    }
    
    func interact() {
        self.room[self.pos.get_pos(inDirection: self.facing)].interact(with: self)
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
    
    func draw_character() {
        self.room.draw_room(with: playerSymbol, at: self.pos)
    }
}
