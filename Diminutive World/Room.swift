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
    let transfers: Dictionary<Position, (String, Position)>
    let name: String
    var blocks: Array2D<Interactable>
    init(name: String, height: Int, width: Int, layout: String,
         transfers: Dictionary<Position, (String, Position)>) {
        /*
         Initializing a room with layout, builds room in height-by-width pattern,
         ignores newlines and everything after the last block in the room has been filled
         */
        self.name = name
        self.blocks = Array2D<Interactable>(rows: height, columns: width)
        self.transfers = transfers
        var i: Int = 0
        var j: Int = 0
        for block in layout.characters {
            if block == "\n" {
                continue
            }
            self.blocks[i, j] = get_interactable(of: block)
            j += 1
            if (j >= width) {
                i += 1
                j = 0
                if (i >= height) {
                    // protect against extra characters
                    break
                }
            }
        }
    }
    
    convenience init(name: String, height: Int, width: Int, layout: String) {
        self.init(name: name, height: height, width: width, layout: layout,
                  transfers: Dictionary<Position, (String, Position)>())
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
    
    
}
