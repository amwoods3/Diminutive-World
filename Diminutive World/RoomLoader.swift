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


func loadRoom(called map: String) -> Room? {
    /*
     Load the room using an xml file. The map name need not include ".xml" as ".xml" is assumed
     */
    let map_name = GameDirectory + MapPath + map + ".xml"
    do {
        let map_data = try String(contentsOfFile: map_name).data(using: String.Encoding.utf8)
        let parser = XMLParser(data: map_data!)
        let delegate = RoomDelegate()
        parser.delegate = delegate
        parser.parse()
        return delegate.room(callit: map)
    } catch {
        print("Nope: \(error)")
    }
    return nil
}
