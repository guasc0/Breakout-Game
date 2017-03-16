//
//  Level2.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-14.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation


class Level2: SKScene, SKPhysicsContactDelegate  {
    
    var hej = SKSpriteNode()
    //var hej2 = SKSpriteNode()
    var ball = SKSpriteNode()
    var touch = false

    override func didMove(to view: SKView) {
        
        hej = self.childNode(withName: "hej") as! SKSpriteNode
        //hej2 = self.childNode(withName: "hej") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
    
    }
    
    
    func touchDown(atPoint pos: CGPoint){
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(ball.position.x)
        if !touch {
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
            touch = true
        }
        
        print(ball.position.x)

        for touch in touches {
            
            let location = touch.location(in: self)
            hej.run(SKAction.moveTo(x: location.x, duration: 0.0))
            //hej2.run(SKAction.moveTo(x: location.x, duration: 0.0))
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            hej.run(SKAction.moveTo(x: location.x, duration: 0.0))
            //hej2.run(SKAction.moveTo(x: location.x, duration: 0.0))
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "ball" && bodyBName == "hej" || bodyAName == "hej" && bodyBName == "ball" {
            // fixa med en bool
            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }




}
