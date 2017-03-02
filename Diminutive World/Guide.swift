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
