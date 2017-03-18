//
//  Save_Load.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

let GameDirectory = "/Users/Andrew/Documents/CS_WORK/Game/Diminutive World/"
let player_data = "saves/"


func save(_ player: Player) {
    let save_path = GameDirectory + player_data + player.name + ".dwplyr"
    let save_string = player.save_string
    do {
        try save_string.write(toFile: save_path, atomically: false, encoding: String.Encoding.ascii)
    } catch {
        print("Error Saving: \(error)")
    }
}

func load(_ player: String) -> Player {
    let load_path = GameDirectory + player_data + player + ".dwplyr"
    do {
        let playerData = try String(contentsOfFile: load_path)
        return Player(fromSave: playerData)
    } catch {
        return Player(called: player)
    }
    
}

