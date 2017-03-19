//
//  Battle.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/20.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

func Battle(_ pl: Player, vs mon: Monster) {
    print("You enter a battle!")
    while true {
        mon.hp -= 1
        print("Monster takes a hit!")
        if mon.hp == 0 {
            print("You win!")
            return
        }
        pl.hp -= 1
        print("Player takes a hit!")
        if pl.hp == 0 {
            print("Game Over!")
            return
        }
        print("HP: \(pl.hp)/\(pl.maxHp)")
    }
}
