//
//  Interactable.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

protocol Interactable: CustomStringConvertible {
    var can_go_through: Bool {get}
    func interact(with: Player)
    func stepped_on(by: Player)
    
}

class EmptySpace: Interactable {
    var can_go_through: Bool = true
    func interact(with: Player) {
        print("There is nothing here")
    }
    
    func stepped_on(by player: Player) {
        if select(at_rate: player.room.battle_rate, out_of: 100) {
            Battle(player, vs: Monster(health: 1))
        }
    }
    var description: String = " "
}
