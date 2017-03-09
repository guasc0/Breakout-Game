//
//  GameScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-09.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKSpriteNode()
    var padel = SKSpriteNode()
    var blocks = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        padel = self.childNode(withName: "padel") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 150))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
        
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            padel.run(SKAction.moveTo(x: location.x, duration: 0.0))
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            padel.run(SKAction.moveTo(x: location.x, duration: 0.0))
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
