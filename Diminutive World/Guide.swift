//
//  Guide.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

func start_menu() -> Bool {
    /*
     Determines if the user wants to start a game or quit
     returns true if the player wants to start a game
     */
    print("***********************************")
    print("*** Diminutive World Start Menu ***")
    print("***********************************")
    print("1. Start Game")
    print("2. Quit")
    let option = Int(readLine()!)
    if option != nil {
        switch option! {
        case 1:
            return true
        case 2:
            return false
        default:
            return false
        }
    }
    return false
}

func welcome() -> Player {
    print("Welcome to my Diminutive World, what is your name?")
    let name = readLine()!
    return load(name)
}

func interpret(_ action: String, done_by p: Player) {
    /*
     Takes a string and performs the appropriate action for the player according to the string
     */
    switch action {
    case "go north", "north", "w":
        p.go(inDirection: Direction.north)
    case "go south", "south", "s":
        p.go(inDirection: Direction.south)
    case "go east", "east", "d":
        p.go(inDirection: Direction.east)
    case "go west", "west", "a":
        p.go(inDirection: Direction.west)
    case "where am i", "whereami":
        print(p.locationInfo())
    case "interact":
        p.interact()
    case "save":
        save(p)
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
        print("  5. interact")
        print("  5. where am i")
        print("  6. quit")
        print("  7. help")
    }
}

func run(with player: Player) {
    /*
     run the game with the player passed in
     */
    player.draw_character()
    while true {
        print(">>> ", terminator: "")
        let action = readLine()
        if action! == "quit" {
            return
        }
        interpret(action!, done_by: player)
        player.draw_character()
    }
}
