//
//  Guide.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

func welcome() -> Player {
    print("Welcome to my Diminutive World, what is your name?")
    let name = readLine()!
    print("Well, \(name), I hope you enjoy this world.")
    return Player(called: name)
}

func interpret(_ action: String, done_by p: Player) {
    /*
     Takes a string and performs the appropriate action for the player according to the string
     */
    switch action {
    case "go north", "north":
        p.go(inDirection: Direction.north)
    case "go south", "south":
        p.go(inDirection: Direction.south)
    case "go east", "east":
        p.go(inDirection: Direction.east)
    case "go west", "west":
        p.go(inDirection: Direction.west)
    case "where am i", "whereami":
        print(p.locationInfo())
    case "help":
        print("Some actions have multiple input that behave in the same way")
        print("  For example \"where am i\" and \"whereami\" both have the same result")
        print("Some alernate options:")
        print("  \"go <direction>\" -> \"<direction>\"")
        print("  \"where am i\" -> \"whereami\"")
    default:
        print("Possible options:")
        print("  1. go north")
        print("  2. go south")
        print("  3. go west")
        print("  4. go east")
        print("  5. where am i")
        print("  6. quit")
        print("  7. help")
    }
}

func run(with player: Player) {
    /*
     run the game with the player passed in
     */
    while true {
        print(">>> ", terminator: "")
        let action = readLine()
        if action! == "quit" {
            return
        }
        interpret(action!, done_by: player)
    }
}
