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

enum IntError: Error {
    case notIntConvertible
}

func to(int str: String) throws -> Int {
    let x = Int(str)
    if x == nil {
        throw IntError.notIntConvertible
    }
    return x!
}

func save(_ player: Player) {
    let save_path = GameDirectory + player_data + player.name + ".dwplyr"
    var data = String()
    data += player.name + "\n"
    data += "\(player.pos.x), \(player.pos.y)" + "\n"
    data += player.room.name + "\n"
    data += "\(player.money)"
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
        let x = try to(int: pos[0])
        let y = try to(int: pos[1])
        let room = playerD[2]
        let money = try to(int: playerD[3])
        return Player(called: player, at: Position(x: x, y: y), in: room, money: money)
    } catch {
        return Player(called: player)
    }
    
}

