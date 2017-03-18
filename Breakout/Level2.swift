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
    
    
    var staticBlock1 = SKSpriteNode()

    var ball = SKSpriteNode()
    var padel = SKSpriteNode()
    var scoreLabel = SKLabelNode(fontNamed: "Pixeled")
    var blocks = SKSpriteNode()
    var totalScore = Level1.score
    var firstTouch = false
    var ballSpeedLabel = SKLabelNode(fontNamed: "Pixeled")
    var ballSpeed = 1
    var audioPlayer: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        let urlPath = Bundle.main.url(forResource: "collision", withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath!)
            audioPlayer.prepareToPlay()
        } catch {
            print("DANGER on the roof")
        }
        
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        padel = self.childNode(withName: "padel") as! SKSpriteNode
        blocks = self.childNode(withName: "blocks") as! SKSpriteNode
        
        scoreLabel.position = CGPoint(x: -230, y: 590)
        scoreLabel.fontSize = 27
        scoreLabel.fontColor = UIColor.red
        scoreLabel.text = "Speed: \(ballSpeed)"
        addChild(scoreLabel)
        
        ballSpeedLabel.position = CGPoint(x: 230, y: 590)
        ballSpeedLabel.fontSize = 27
        ballSpeedLabel.fontColor = UIColor.green
        ballSpeedLabel.text = "Speed: \(ballSpeed)"
        addChild(ballSpeedLabel)
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
        
        
    }
    
    // func to randomize between 2 numbers
    func randXImpulse (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let randX = randXImpulse(lower: -80, upper: 80)
        
        if !firstTouch{
            ball.physicsBody?.velocity.dy = 500
            ball.physicsBody?.applyImpulse(CGVector(dx: randX + 2, dy: 0))
            firstTouch = true
            print(randX)
            
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
            
            // check where the padel is and gives it a push in the opposite direction
            if padel.position.x < -150 {
                ball.physicsBody?.applyImpulse(CGVector(dx: randXImpulse(lower: 0, upper: 30), dy: 0))
                
            } else if padel.position.x > 150 {
                ball.physicsBody?.applyImpulse(CGVector(dx: randXImpulse(lower: -30, upper: 0), dy: 0))
                
            }
            
            // Checks the score and increase ballspeed
            if totalScore >= 30 && ballSpeed == 1{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.velocity.dy = 600
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
                
            } else if totalScore >= 35 && ballSpeed == 2{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.velocity.dy = 700
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            } else if totalScore >= 40 && ballSpeed == 3{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.velocity.dy = 800
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            } else if totalScore >= 45 && ballSpeed == 4{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.velocity.dy = 900
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            } else if totalScore >= 50 && ballSpeed == 5{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.velocity.dy = 950
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            } else if totalScore >= 55 && ballSpeed == 6{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.velocity.dy = 1000
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            }
        }
        
        
        if bodyAName == "ball" && bodyBName == "blocks" || bodyAName == "blocks" && bodyBName == "ball"{
            
            // Removes the blocks and sets the score
            if bodyAName == "blocks" {
                audioPlayer.play()
                contact.bodyA.node?.removeFromParent()
                totalScore += 1
                
            } else if bodyBName == "blocks"{
                audioPlayer.play()
                contact.bodyB.node?.removeFromParent()
                totalScore += 1
                
            }
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // checking if player win or lose
        
        scoreLabel.text = "Score: \(totalScore)"
        if totalScore == 61{
            
            let youWonScene = GameOverScene(size: self.frame.size, playerWon:true)
            self.view?.presentScene(youWonScene, transition: SKTransition.doorway(withDuration: 1.0))
            
        }
        
        if ball.position.y < padel.position.y{
            
            let youLostScene = GameOverScene(size: self.frame.size, playerWon:false)
            self.view?.presentScene(youLostScene, transition: SKTransition.doorway(withDuration: 1.0))
            
        }
        
        Level1.score = totalScore
        
    }
    
}

