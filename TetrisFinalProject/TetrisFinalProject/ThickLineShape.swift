//
//  ThickLineShape.swift
//  TetrisFinalProject
//
//  Created by Alex Lee on 8/14/16.
//  Copyright © 2016 Alex Lee. All rights reserved.
//

class ThickLineShape: Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(0, 0), (0, 1), (0, 2), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3)],
            Orientation.Ninety:     [(-1,0), (0, 0), (1, 0), (2, 0), (-1, 1), (0, 1), (1, 1), (2, 1)],
            Orientation.OneEighty:  [(0, 0), (0, 1), (0, 2), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3)],
            Orientation.TwoSeventy: [(-1,0), (0, 0), (1, 0), (2, 0), (-1, 1), (0, 1), (1, 1), (2, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[FourthBlockIdx]],
            Orientation.Ninety:     blocks,
            Orientation.OneEighty:  [blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: blocks
        ]
    }
}
