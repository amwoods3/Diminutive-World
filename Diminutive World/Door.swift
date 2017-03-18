//
//  Door.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/05.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

class Door: Interactable {
    var can_go_through: Bool = true
    var connecting_room: String
    var connecting_position: Position
    
    var description: String = "="
    
    init(connecting_room: String, connecting_position: Position) {
        self.connecting_room = connecting_room
        self.connecting_position = connecting_position
    }
    
    func interact(with: Player) {
        print("A door, you can use it to transfer to another room")
    }
    
    func stepped_on(by p: Player) {
        print("You enter \(connecting_room).")
        p.room = loadRoom(called: connecting_room)!
        p.pos = connecting_position
    }
}
