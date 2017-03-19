//
//  Level1.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-09.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class Level1: SKScene, SKPhysicsContactDelegate  {
    
    
    var ball = SKSpriteNode()
    var padel = SKSpriteNode()
    var scoreLabel = SKLabelNode(fontNamed: "Pixeled")
    var blocks = SKSpriteNode()
    static var score: Int = 0
    var totalScore = 0
    var firstTouch = false
    var ballSpeedLabel = SKLabelNode(fontNamed: "Pixeled")
    var ballSpeed = 1
    var audioPlayer: AVAudioPlayer!
    var audioPlayer2: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        
        addSound()
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

    func addSound(){
        let urlPath = Bundle.main.url(forResource: "collision", withExtension: "wav")!
        let urlPath2 = Bundle.main.url(forResource: "gameover", withExtension: "wav")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath)
            audioPlayer.prepareToPlay()
        } catch {
            print("DANGER on the roof")
        }
        
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: urlPath2)
            audioPlayer2.prepareToPlay()
        } catch {
            print("DANGER on the roof")
        }
    }
    
    // func to randomize between a negative and positive numbers
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
            if totalScore >= 5 && ballSpeed == 1{
                ball.physicsBody?.velocity.dy = 600
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                print("velocity: \(ball.physicsBody?.velocity.dy)")
                
                
            } else if totalScore >= 10 && ballSpeed == 2{
                ball.physicsBody?.velocity.dy = 700
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                print("velocity: \(ball.physicsBody?.velocity.dy)")
                
            } else if totalScore >= 15 && ballSpeed == 3{
                ball.physicsBody?.velocity.dy = 800
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                print("velocity: \(ball.physicsBody?.velocity.dy)")
                
            } else if totalScore >= 20 && ballSpeed == 4{
                ball.physicsBody?.velocity.dy = 900
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                print("velocity: \(ball.physicsBody?.velocity.dy)")
                
                
            }
        }
        
        // checks if the ball and blocks collides
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
    
        scoreLabel.text = "Score: \(totalScore)"
        if totalScore == 25{
            
            let nextLevel = NextLevelScene(fileNamed: "NextLevelScene")
            nextLevel?.scaleMode = .aspectFill
            self.view?.presentScene(nextLevel!, transition: SKTransition.doorway(withDuration: 1.0))
        
        }
    
        if ball.position.y < padel.position.y{
            
            let youLostScene = GameOverScene(size: self.frame.size, playerWon:false)
            self.view?.presentScene(youLostScene, transition: SKTransition.doorway(withDuration: 1.0))
            audioPlayer2.play()
        }
        
        Level1.score = totalScore
    }
    
    
    
}
