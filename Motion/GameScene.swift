//
//  GameScene.swift
//  Motion
//
//  Created by cedric jo on 11/18/15.
//  Copyright (c) 2015 cedric jo. All rights reserved.
//

import SpriteKit
import CoreMotion


let AirplaneCategoryName = "airplane"
let PlaneCategory : UInt32 = 0x1 << 0
let BottomCategory: UInt32 = 0x1 << 1
let TopCategory : UInt32 = 0x1 << 2
let RightCategory: UInt32 = 0x1 << 3
let LeftCategory: UInt32 = 0x1 << 4

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var plane =  SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var destY:CGFloat = 0.0
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        physicsWorld.contactDelegate = self
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        plane = childNodeWithName(AirplaneCategoryName) as! SKSpriteNode
//        plane.physicsBody!.applyImpulse(CGVectorMake(100, 100))
        
//        airplane = SKSpriteNode(imageNamed: "Airplane")
//                airplane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
//                self.addChild(airplane)
//        
        plane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        
                if motionManager.accelerometerAvailable == true {
                    // 2
                    motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                        data, error in
        
                        let currentX = self.plane.position.x
                        let currentY = self.plane.position.y
        
                        // 3
                        if data!.acceleration.x < 0 {
                            self.destX = currentX + CGFloat(data!.acceleration.x * 500) + CGFloat(arc4random_uniform(500)) - CGFloat(arc4random_uniform(500))
                        }
        
                        else if data!.acceleration.x > 0 {
                            self.destX = currentX + CGFloat(data!.acceleration.x * 500) + CGFloat(arc4random_uniform(1000)) - CGFloat(arc4random_uniform(500))
                        }
                        self.destY = currentY + CGFloat(data!.acceleration.y * 500)
                        self.destY = currentY + CGFloat(data!.acceleration.y * 500)
                        
                    })
                    
                }

        plane.physicsBody!.allowsRotation = false
        plane.physicsBody!.friction = 0
        plane.physicsBody!.restitution = 1
        plane.physicsBody!.linearDamping = 0
        plane.physicsBody!.angularDamping = 0
        plane.size = CGSize(width: -125, height: 70)
        
//        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1)
//        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1)
//        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1)
        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        addChild(bottom)
        
        bottom.physicsBody!.categoryBitMask = BottomCategory
        plane.physicsBody!.categoryBitMask = PlaneCategory
        plane.physicsBody!.contactTestBitMask = BottomCategory
        
        
        }
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == PlaneCategory && secondBody.categoryBitMask == BottomCategory {
            print("Hit Bottom")
            if let mainView = view {
                let gameOverScene = GameOverScene(fileNamed:"GameOverScene")
                gameOverScene!.gameWon = false
                mainView.presentScene(gameOverScene)
            }
        }
    }
    
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 45;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        
        
//        airplane = SKSpriteNode(imageNamed: "Airplane")
//        airplane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
//        self.addChild(airplane)
//        
//        if motionManager.accelerometerAvailable == true {
//            // 2
//            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
//                data, error in
//                
//                let currentX = self.airplane.position.x
//                let currentY = self.airplane.position.y
//                
//                // 3
//                if data!.acceleration.x < 0 {
//                    self.destX = currentX + CGFloat(data!.acceleration.x * 500)
//                }
//                    
//                else if data!.acceleration.x > 0 {
//                    self.destX = currentX + CGFloat(data!.acceleration.x * 500)
//                }
//                self.destY = currentY + CGFloat(data!.acceleration.y * 500)
//                self.destY = currentY + CGFloat(data!.acceleration.y * 500)
//                
//            })
//            
//        }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var action = SKAction.moveToX(destX, duration: 1)
        var actiony = SKAction.moveToY(destY, duration: 1)
        self.plane.runAction(actiony)
        self.plane.runAction(action)
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
