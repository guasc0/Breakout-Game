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
        
        scoreLabel.position = CGPoint(x: -230, y: 600)
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.red
        scoreLabel.text = "Speed: \(ballSpeed)"
        addChild(scoreLabel)
        
        ballSpeedLabel.position = CGPoint(x: 200, y: 600)
        ballSpeedLabel.fontSize = 30
        ballSpeedLabel.fontColor = UIColor.green
        ballSpeedLabel.text = "Speed: \(ballSpeed)"
        addChild(ballSpeedLabel)
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
        
       
    }
    
    func randXImpulse (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let randX = randXImpulse(lower: -100, upper: 100)
        
        if !firstTouch{
            ball.physicsBody?.applyImpulse(CGVector(dx: randX + 2, dy: 100))
            //ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
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
            //ball.physicsBody?.applyImpulse(CGVector(dx: randXImpulse(lower: -30, upper: 30), dy: 0))
            if totalScore == 5 && ballSpeed == 1{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            }
            
            if totalScore == 10 && ballSpeed == 2{
                print("vi kör fart \(ballSpeed)")
                
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            }
            
            if totalScore == 15 && ballSpeed == 3{
                print("vi kör fart \(ballSpeed)")
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
                ballSpeed += 1
                ballSpeedLabel.text = "Speed: \(ballSpeed)"
                
            }
        }
        
      
        if bodyAName == "ball" && bodyBName == "blocks" || bodyAName == "blocks" && bodyBName == "ball"{
            
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
    
    if ball.position.x == ball.position.y{
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 100))
    }
    
    scoreLabel.text = "Score: \(totalScore)"
    if totalScore == 25{
            
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
