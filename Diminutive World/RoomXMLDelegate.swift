//
//  RoomXMLDelegate.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/10.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

class RoomBuilder: NSObject, XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("I am in parser 1: \(elementName)")
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("I am in parser 2: \(elementName)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("I am in parser 3: \(string)")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("I am in parser 4")
    }
}
