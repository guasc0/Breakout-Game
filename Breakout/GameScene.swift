//
//  GameScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-09.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
    
    //var playerBall : Ball!
    var target : CGPoint = CGPoint(x: 0, y: 0)
    var ball = SKSpriteNode()
    var padel = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var blocks = SKSpriteNode()
    var score: Int = 0 
    var firstTouch = false
    
    var audioPlayer: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        let urlPath = Bundle.main.url(forResource: "collision", withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath!)
            audioPlayer.prepareToPlay()
        } catch {
            print("DANGER on the roof")  
        }
        
        
        //createBall()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        //let ballSprite = SKSpriteNode(imageNamed: "ball")
        //playerBall = Ball(sprite: ballSprite)
        //playerBall.sprite.position = CGPoint(x: self.frame.midX, y: -600)
        //playerBall.sprite.xScale = 0.25
        //playerBall.sprite.yScale = 0.25
        //addChild(ballSprite)
        
        padel = self.childNode(withName: "padel") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "score") as! SKLabelNode
        blocks = self.childNode(withName: "blocks") as! SKSpriteNode
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
        
        
       
    }
    
    func touchDown(atPoint pos : CGPoint) {
        target = pos
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !firstTouch{
            ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 100))
            firstTouch = true
        }
        
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
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "ball" && bodyBName == "padel" || bodyAName == "padel" && bodyBName == "ball" {
            if score == 5 {
                ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -100))
                ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 150))
            } else if score == 10 {
                ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -150))
                ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 200))
            }
            
        }
        
        if bodyAName == "ball" && bodyBName == "blocks" || bodyAName == "blocks" && bodyBName == "ball"{
            
            if bodyAName == "blocks" {
                audioPlayer.play()
                contact.bodyA.node?.removeFromParent()
                score += 1
               
            } else if bodyBName == "blocks"{
                audioPlayer.play()
                contact.bodyB.node?.removeFromParent()
                score += 1
            }
            
        
        }
        
        
    }
    
  override func update(_ currentTime: TimeInterval) {
        scoreLabel.text = "Score: \(score)"
        if score == 25{
            
            let youWonScene = GameOverScene(size: self.frame.size, playerWon:true)
            self.view?.presentScene(youWonScene, transition: SKTransition.doorway(withDuration: 1.0))
           
        }
        
        if ball.position.y < padel.position.y{
            
            let youLostScene = GameOverScene(size: self.frame.size, playerWon:false)
            self.view?.presentScene(youLostScene, transition: SKTransition.doorway(withDuration: 1.0))
            
        }
        
    }
    
    /*var t : Double?
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let t = t {
            let deltaTime = currentTime - t
            playerBall.update(deltaTime: Float(deltaTime))
            
            let dx = target.x - 100
            let dy = target.y - -1000
            playerBall.direction = atan2f(Float(dy), Float(dx))
            
        }
        
        t = currentTime
        
        
    }*/
    
}
