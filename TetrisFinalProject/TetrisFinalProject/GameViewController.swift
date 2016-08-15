//
//  GameViewController.swift
//  TetrisFinalProject
//
//  Created by Alex Lee on 8/6/16.
//  Copyright (c) 2016 Alex Lee. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController, TetrisGameDelegate, UIGestureRecognizerDelegate {
    
    var scene: TetrisScene!
    var tetrisGame:TetrisGame!
    
    var panPointReference:CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        
        scene = TetrisScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        
        scene.tick = didTick
        
        tetrisGame = TetrisGame()
        tetrisGame.delegate = self
        tetrisGame.beginGame()
        
        // show scene
        skView.presentScene(scene)
        
        
    }
    @IBAction func didDwipe(sender: UISwipeGestureRecognizer) {
        tetrisGame.dropShape()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            // #3
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                // #4
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    tetrisGame.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    tetrisGame.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    func didTick() {
        tetrisGame.letShapeFall()
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        tetrisGame.rotateShape()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
    func nextShape() {
        let newShapes = tetrisGame.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
        self.scene.movePreviewShape(fallingShape) {
            self.view.userInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(tetrisGame: TetrisGame) {
        // The following is false when restarting a new game
        if tetrisGame.nextShape != nil && tetrisGame.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(tetrisGame.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(tetrisGame: TetrisGame) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(tetrisGame: TetrisGame) {
        
    }
    
    func gameShapeDidDrop(tetrisGame: TetrisGame) {
        scene.stopTicking()
        scene.redrawShape(tetrisGame.fallingShape!) {
            tetrisGame.letShapeFall()
        }
    }
    
    func gameShapeDidLand(tetrisGame: TetrisGame) {
        scene.stopTicking()
        let removedLines = tetrisGame.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            //self.scoreLabel.text = "\(tetrisGame.score)"
            scene.animateCollapsingLines(removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                self.gameShapeDidLand(tetrisGame)
            }
        } else {
            nextShape()
        }
    }
    
    func gameShapeDidMove(tetrisGame: TetrisGame) {
        scene.redrawShape(tetrisGame.fallingShape!) {}
    }

}
