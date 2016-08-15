//
//  Array2D.swift
//  TetrisFinalProject
//
//  Created by Alex Lee on 8/6/16.
//  Copyright © 2016 Alex Lee. All rights reserved.
//

import Foundation


class Array2D<T> {
    
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        self.array = Array<T?>(count:rows * columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return self.array[(row * self.columns) + column]
        }
        
        set(newValue) {
            array[(row * self.columns) + column] = newValue
        }
    }
}