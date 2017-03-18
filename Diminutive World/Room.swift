//
//  Room.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation
func get_interactable(of c: Character) -> Interactable {
    switch c {
    case "#", "|", "-", "_":
        return Wall(image: String(c))
    case " ":
        return EmptySpace()
    default:
        return Wall(image: String(c))
    }
}

class Room {
    /*
     Room gives a player the ability to walk around and go to other rooms.
     */
    var transfers: Dictionary<Position, (String, Position)>
    let name: String
    var blocks: Array2D<Interactable>
    
    init(_ name: String, of_size height: Int, by width: Int) {
        self.name = name
        self.blocks = Array2D(rows: height, columns: width)
        for row in 0...height-1 {
            for col in 0...width-1 {
                if row == 0 || row == height-1 || col == 0 || col == height-1 {
                    self.blocks[row, col] = Wall(image: "#")
                } else {
                    self.blocks[row, col] = EmptySpace()
                }
            }
        }
        transfers = Dictionary()
    }
    
    
    
    subscript(pos: Position) -> Interactable {
        get {
            return blocks[pos.y, pos.x]
        }
    }
    
    func display_self() {
        self.draw_room(with: " ")
    }
    
    func draw_room(with player: Character, at pos: Position?=nil) {
        
        for (i, row) in self.blocks.enumerated() {
            for (j, block) in row.enumerated() {
                if pos == nil {
                    print(block, terminator: "")
                } else if i == pos!.y && j == pos!.x {
                    print(player, terminator: "")
                } else {
                    print(block, terminator: "")
                }
            }
            print()
        }
    }
    
    func add_transfer(at p: Position, heading_to op: Position, in room: String) {
        transfers[p] = (room, op)
        self.blocks[p] = Door(connecting_room: room, connecting_position: op)
    }
    
    func change_block(at pos: Position, to this: Interactable) {
        self.blocks[pos] = this
    }
    
}
