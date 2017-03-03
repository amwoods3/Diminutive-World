//
//  main.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation


let roomA = Room(height: 4, width: 5, layout: "_____\n#   #\n#   #\n-----\n$$$$")
roomA.display_self()
// roomB should have the same layout as roomA
let roomB = Room(height: 4, width: 5, layout: "_____#   ##   #-----$$$$")
roomB.display_self()
while true {
    if (start_menu()) {
        var player = welcome()
        run(with: player)
    }
    else {
        break
    }
}
