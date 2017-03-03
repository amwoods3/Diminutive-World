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
    var data = String()
    data += player.name + "\n"
    data += "\(player.pos.x), \(player.pos.y)" + "\n"
    data += player.room.name + "\n"
    do {
        try data.write(toFile: save_path, atomically: false, encoding: String.Encoding.ascii)
    } catch {
        print("Error Saving: \(error)")
    }
}

func load(_ player: String) -> Player {
    let load_path = GameDirectory + player_data + player + ".dwplyr"
    do {
        let playerData = try String(contentsOfFile: load_path)
        let playerD = playerData.components(separatedBy: "\n")
        let pos = split(line: playerD[1], by: ",")
        let x = Int(pos[0])!
        let y = Int(pos[1])!
        let room = playerD[2]
        return Player(called: player, at: Position(x: x, y: y), in: room)
    } catch {
        return Player(called: player)
    }
    
}

