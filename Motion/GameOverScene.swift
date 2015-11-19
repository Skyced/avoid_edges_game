//
//  GameOverScene.swift
//  Motion
//
//  Created by cedric jo on 11/19/15.
//  Copyright © 2015 cedric jo. All rights reserved.
//


import SpriteKit

let GameOverLabelCategoryName = "gameOverLabel"

class GameOverScene: SKScene {
    var gameWon : Bool = false {
        // 1.
        didSet {
            let gameOverLabel = childNodeWithName(GameOverLabelCategoryName) as! SKLabelNode
            gameOverLabel.text = gameWon ? "Game Won" : "Game Over!!!!!!!!"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let view = view {
            // 2.
            let gameScene = GameScene(fileNamed: "GameScene")
            view.presentScene(gameScene)
        }
    }
}
