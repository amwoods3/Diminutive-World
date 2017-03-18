//
//  SimpleFunctions.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/18.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

func split(line str: String, by splitter: String) -> Array<String> {
    /*
     Splits a string based on splitter, this function removes all spaces
     */
    var components = str.components(separatedBy: splitter)
    for i in 0...components.count-1 {
        components[i] = components[i].trimmingCharacters(in: CharacterSet(charactersIn: " \n\t"))
    }
    return components
}

func can_find(_ element: String, in array: Array<String>) -> Bool {
    for string in array {
        if element == string {
            return true
        }
    }
    return false
}

enum ToError: Error {
    case notIntConvertible
    case notPositionConvertible
}

func to(int str: String) throws -> Int {
    let x = Int(str)
    if x == nil {
        throw ToError.notIntConvertible
    }
    return x!
}


func to(position str: String) throws -> Position {
    let b = split(line: str, by: ",")
    do {
        let x = try to(int: b[0])
        let y = try to(int: b[1])
        return Position(x: x, y: y)
    } catch ToError.notIntConvertible {
        throw ToError.notPositionConvertible
    }
}
