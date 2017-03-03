//
//  Room.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

class Room {
    /*
     Room gives a player the ability to walk around and go to other rooms.
     */
    let transfers: Dictionary<Position, (Room, Position)>
    var blocks: Array2D<Character>
    init(height: Int, width: Int, layout: String,
         transfers: Dictionary<Position, (Room, Position)>) {
        /*
         Initializing a room with layout, builds room in height-by-width pattern,
         ignores newlines and everything after the last block in the room has been filled
         */
        self.blocks = Array2D<Character>(rows: height, columns: width)
        self.transfers = transfers
        var i: Int = 0
        var j: Int = 0
        for block in layout.characters {
            if block == "\n" {
                continue
            }
            self.blocks[i, j] = block
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
    
    convenience init(height: Int, width: Int, layout: String) {
        self.init(height: height, width: width, layout: layout,
                  transfers: Dictionary<Position, (Room, Position)>())
    }
    func display_self() {
        for row in self.blocks {
            for block in row {
                print(block, terminator: "")
            }
            print()
        }
    }
}
