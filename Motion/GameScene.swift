//
//  GameScene.swift
//  Motion
//
//  Created by cedric jo on 11/18/15.
//  Copyright (c) 2015 cedric jo. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    var airplane = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var destY:CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 45;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        airplane = SKSpriteNode(imageNamed: "Airplane")
        airplane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.addChild(airplane)
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                
                let currentX = self.airplane.position.x
                let currentY = self.airplane.position.y
                
                // 3
                if data!.acceleration.x < 0 {
                    self.destX = currentX + CGFloat(data!.acceleration.x * 1000)
                }
                    
                else if data!.acceleration.x > 0 {
                    self.destX = currentX + CGFloat(data!.acceleration.x * 1000)
                }
                self.destY = currentY + CGFloat(data!.acceleration.y * 1000)
                self.destY = currentY + CGFloat(data!.acceleration.y * 1000)
                
            })
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var action = SKAction.moveToX(destX, duration: 1)
        var actiony = SKAction.moveToY(destY, duration: 1)
        self.airplane.runAction(actiony)
        self.airplane.runAction(action)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   

}
