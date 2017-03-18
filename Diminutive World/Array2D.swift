//
//  2DArray.swift
//  Diminutive World
//
//  Created by Andrew Woods on 2017/03/03.
//  Copyright © 2017年 Andrew Woods. All rights reserved.
//

import Foundation

struct Array2DIterator<T>: IteratorProtocol {
    var idx: Int
    var array: Array2D<T>
    init(_ array: Array2D<T>) {
        self.idx = 0
        self.array = array
    }
    
    mutating func next() -> Array<T>? {
        if idx >= array.size {
            return nil
        }
        let n = array[idx]
        idx += 1
        return n
    }
}

class Array2D<T>: Sequence {
    let rows: Int
    let columns: Int
    var arr: Array<Array<T?>>
    
    var size: Int {
        return arr.count
    }
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.arr = Array(repeating: Array<T?>(repeating: nil, count: columns), count: rows)
    }
    
    subscript(row: Int, col: Int) -> T {
        get {
            return arr[row][col]!
        }
        set(newValue) {
            arr[row][col] = newValue
        }
    }
    
    subscript(pos: Position) -> T {
        get {
            return arr[pos.y][pos.x]!
        }
        set(newValue) {
            arr[pos.y][pos.x] = newValue
        }
    }
    
    subscript(row: Int) -> Array<T> {
        /*
         Single subscript provides only a get method returns an Array with type T
         */
        get {
            return arr[row] as! Array<T>
        }
    }
    
    func makeIterator() -> Array2DIterator<T> {
        return Array2DIterator(self)
    }
}
