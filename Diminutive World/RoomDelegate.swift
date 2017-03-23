//
//  RoomXMLDelegate.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/10.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation



class RoomDelegate: NSObject, XMLParserDelegate {
    
    var doors: Dictionary<Int, (pos: Position?,  des: String?, con: Position?) > = [:]
    var extra_walls: Dictionary<Int, Position?> = [:]
    var room_height: Int = 0
    var room_width: Int = 0
    var battle_rate: Int?
    var current_door: Int = 0
    var current_wall: Int = 0
    var building: String? = nil
    var identifying: String? = nil
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        /*
         Helps get the current state of the parser and builds the correct interactable to put in the room.
         */
        if elementName == "door" {
            building = "door"
            doors[current_door] = (nil, nil, nil)
            identifying = nil
        } else if elementName == "wall" {
            building = "wall"
            extra_walls[current_wall] = nil
            identifying = nil
        } else {
            if can_find(elementName, in: ["location", "size", "destinationLocation", "destinationRoom",
                                          "battleRate"]) {
                identifying = elementName
            }
            else {
                identifying = nil
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        /*
         This parser represents the end of a tag.
         */
        if elementName == "door" {
            current_door += 1 // next door
            building = nil
        } else if elementName == "wall" {
            current_wall += 1 // next wall
            building = nil
        }
        if elementName == identifying {
            identifying = nil
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /*
         This parser gives the information that is in the tag.
         */
        if identifying == "size" {
            // Get the size of the room
            let size = split(line: string, by: ",")
            do {
                room_width = try to(int: size[0])
                room_height = try to(int: size[1])
            } catch {
                print("The size could not be determined")
            }
        }
        else if identifying == "battleRate" {
            // Determine how oftern a battle starts while walking in the room.
            // The battle rate is out of 100 (anything above 100 results in a battle every step)
            do {
                battle_rate = try to(int: trim(string))
            } catch {
                print("Battle Rate?")
            }
        }
        else if identifying == "location" {
            if building == "door" {
                do {
                doors[current_door]!.pos = try to(position: string)
                } catch {
                    print("Well, I don't know where to put this door")
                }
            }
        }
        if identifying == "destinationRoom" {
            if building == "door" {
                doors[current_door]!.des = trim(string)
            }
        }
        if identifying == "destinationLocation" {
            if building == "door" {
                do {
                    doors[current_door]!.con = try to(position: string)
                } catch {
                    print("Well, I have no idea where this door leads too.")
                }
            }
        }
        if building == "wall" && identifying == nil && !string.isEmpty {
            do {
                extra_walls[current_wall] = try to(position: string)
            } catch {
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Error : \(parseError)")
    }
    
    func room(callit name: String) -> Room {
        // First get the room developed
        let this_room = Room(name, of_size: room_height, by: room_width)
        if current_door > 0 {
            for door in 0...current_door-1 {
                if doors[door]!.pos != nil && doors[door]!.con != nil && doors[door]!.des != nil {                    this_room.add_transfer(at: doors[door]!.pos!, heading_to: doors[door]!.con!, in: doors[door]!.des!)
                }
            }
        }
        if current_wall > 0 {
            for wall in 0...current_wall-1 {
                if extra_walls[wall] != nil {
                    this_room.change_block(at: extra_walls[wall]!!, to: Wall(image: "#"))
                }
            }
        }
        if battle_rate != nil {
            this_room.set_battle_rate(to: battle_rate!)
        }
        return this_room
    }
}
