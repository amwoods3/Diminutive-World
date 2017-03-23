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
    var hp: Int
    var maxHp: Int
    var exp: Int
    
    var save_string: String {
        /*
         This variable takes all of the variables from the player and puts it in a format that could be 
         used to reload the character at a later time.
         */
        var data = String()
        data += self.name + "\n"
        data += "\(self.pos.x), \(self.pos.y)" + "\n"
        data += self.room.name + "\n"
        data += "\(self.money)" + "\n"
        data += "\(self.hp)" + "\n"
        data += "\(self.maxHp)" + "\n"
        data += "\(self.exp)"
        return data
    }
    
    init(called name: String, at pos: Position, in room: String, money: Int,
         hp: Int=10, maxHp: Int=10, exp: Int=0) {
        self.name = name
        self.pos = pos
        self.room = loadRoom(called: room)!
        
        self.facing = Direction.north
        self.money = money
        self.hp = hp
        self.maxHp = maxHp
        self.exp = exp
    }
    
    convenience init(called name: String) {
        /*
         Load a generic character
         */
        self.init(called: name, at: startingPosition, in: startingRoom, money: 0)
    }
    
    convenience init(fromSave playerData: String) {
        /*
         Load a character from a save string. This corresponds to the character save_string variable class.
         */
        let playerD = playerData.components(separatedBy: "\n")
        let name = playerD[0]
        let pos = split(line: playerD[1], by: ",")
        do {
            let x = try to(int: pos[0])
            let y = try to(int: pos[1])
            let room = playerD[2]
            let money = try to(int: playerD[3])
            let hp = try to(int: playerD[4])
            let maxHp = try to(int: playerD[5])
            let exp = try to(int: playerD[6])
            self.init(called: name, at: Position(x: x, y: y), in: room, money: money,
                      hp: hp, maxHp: maxHp, exp: exp)
        } catch {
            self.init(called: name)
        }
    }
    
    func go(inDirection d: Direction) {
        /*
         Move Player in given Direction (Direction.north, Direction.south, Direction.west, Direction.east)
         */
        if check(inDirection: d) {
            // move player if spot can be stood in
            pos.move(inDirection: d);
            self.facing = d
        } else {
            print("can't go there!")
        }
        // Every Interactable has a stepped_on function, this function determines what happens when the player
        // Steps on the interactable (a door transfers the player to another location, etc).
        self.room[self.pos].stepped_on(by: self)
    }
    
    func check(inDirection d: Direction) -> Bool {
        /*
         Checks if the interactable in the given direction can be stepped on
         */
        return self.room[self.pos.get_pos(inDirection: d)].can_go_through
    }
    
    func interact() {
        self.room[self.pos.get_pos(inDirection: self.facing)].interact(with: self)
    }
    
    
    func locationInfo(in language: String="English") -> String {
        switch language {
        case "English":
            return "\(name) is standing at <\(pos.x), \(pos.y)> in \(room)"
        case "Japanese":
            return "\(name)は\(room)の<\(pos.x), \(pos.y)>にいる"
        default:
            return "<\(pos.x), \(pos.y)>"
        }
    }
    
    func draw_character() {
        self.room.draw_room(with: playerSymbol, at: self.pos)
    }
}
