//
//  Wall.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

class Wall: Interactable {
    var can_go_through: Bool = false
    var image: String
    init(image: String) {
        self.image = image
    }
    func interact(with: Player) {
        print("A wall, you can't walk through it")
    }
    var description: String {
        return image
    }
}
