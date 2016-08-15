//
//  SmallLShape.swift
//  TetrisFinalProject
//
//  Created by Alex Lee on 8/14/16.
//  Copyright © 2016 Alex Lee. All rights reserved.
//

class SmallLShape: Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [ (0, 0), (0, 1),  (1, 1)],
            Orientation.Ninety:     [ (0, 0), (1, 0),  (1, 1)],
            Orientation.OneEighty:  [ (1, 0), (1, 1),  (0, 1)],
            Orientation.TwoSeventy: [ (0, 0), (1, 0),  (0, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.Ninety:     [blocks[ThirdBlockIdx]],
            Orientation.OneEighty:  [blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.TwoSeventy: [blocks[ThirdBlockIdx]],
        ]
    }
}
