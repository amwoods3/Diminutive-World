//
//  main.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

let starterRoom = loadRoom(called: "startersRoom")
starterRoom.display_self()

while true {
    if (start_menu()) {
        var player = welcome()
        run(with: player)
    }
    else {
        break
    }
}
