//
//  MapLoader.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

// The MapPath is computer specific, and won't work on any other computer
// Should be changed to fit the computer it is on
// Wonder how this could be done
let MapPath = "assets/"


func split(line str: String, by splitter: String) -> Array<String> {
    /*
     Splits a string based on splitter, this function removes all spaces
     */
    var components = str.components(separatedBy: splitter)
    for i in 0...components.count-1 {
        components[i] = components[i].trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    return components
}

func loadRoom(called map: String) -> Room {
    /*
     This function assumes the room file is in the proper format,
     If the file does not exist a default room is returned
     TODO: Add throwing error if file does not exist
     */
    let map_name = GameDirectory + MapPath + map
    do {
        // Read the file into memory; interpret its contents
        let mapInfo = try String(contentsOfFile: map_name)
        let mapInfoComponents = mapInfo.components(separatedBy: "\n")
        let mapSize = split(line: mapInfoComponents[0], by: ",")
        
        // Attempt to get height and width, this will break if format is not correct
        let height = try to(int: mapSize[0])
        let width = try to(int: mapSize[1])
        
        // build layout (this assumes the room size is correct)
        var layout = String()
        for i in 1...height {
            layout.write(mapInfoComponents[i])
        }
        
        // Get all doors and put the information in other rooms
        var transfers = Dictionary<Position, (String, Position)>()
        for i in height+1...mapInfoComponents.count-2 {
            // The file is expected to have the following format:
            // x, y, destinationRoom, destinationRoom_x, destinationRoom_y
            // Example:
            // 0, 5, roomB, 10, 4
            let transfer = split(line: mapInfoComponents[i], by: ",")
            let pos = Position(x: try to(int: transfer[0]), y: try to(int: transfer[1]))
            let destination = transfer[2]
            let dest_pos = Position(x: Int(transfer[3])!, y: Int(transfer[4])!)
            transfers[pos] = (destination, dest_pos)
        }
        
        // build room and return it
        return Room(name: map, height: height, width: width, layout: layout, transfers: transfers)
    } catch {
        // TODO: Find Different names for each error
        print("Error: \(error)")
        
    }
    return Room(name: "default", height: 4, width: 5, layout: "_____\n#   #\n#   #\n-----\n$$$$")
}
