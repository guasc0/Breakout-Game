//
//  StartGameScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-12.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit
import QuartzCore

class StartGameScene: SKScene, SKPhysicsContactDelegate {
    
    
    override func didMove(to view: SKView) {
        
    
        let titleLabel = SKLabelNode(fontNamed: "Avenir-Black")
        let titleLabel2 = SKLabelNode(fontNamed: "Avenir-Black")
        let startGameLabel1 = SKLabelNode(fontNamed: "Avenir-Black")
        let startGameLabel2 = SKLabelNode(fontNamed: "Avenir-Black")
        let tapToPlay = SKLabelNode(fontNamed: "Avenir-Black")
        var ball1 = SKSpriteNode()
        var ball2 = SKSpriteNode()
        var ball3 = SKSpriteNode()
        
        self.backgroundColor = UIColor.black
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
        
        ball1 = self.childNode(withName: "ball1") as! SKSpriteNode
        ball1.physicsBody?.applyImpulse(CGVector(dx: 400, dy: 500))
        ball2 = self.childNode(withName: "ball2") as! SKSpriteNode
        ball2.physicsBody?.applyImpulse(CGVector(dx: 300, dy: -500))
        ball3 = self.childNode(withName: "ball3") as! SKSpriteNode
        ball3.physicsBody?.applyImpulse(CGVector(dx: 400, dy: 500))

        
        titleLabel.position = CGPoint(x: -200, y: 200)
        titleLabel.fontSize = 80
        titleLabel.fontColor = UIColor.green
        titleLabel.text = "BLOCK"
        
        
        titleLabel2.position = CGPoint(x: 150, y: 200)
        titleLabel2.fontSize = 80
        titleLabel2.fontColor = UIColor.red
        titleLabel2.text = "CRUSHER"
        
        
        
        startGameLabel1.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        startGameLabel1.fontSize = 35
        startGameLabel1.text = "Move the paddle sideways to hit the "
        
        startGameLabel2.position = CGPoint(x: self.frame.midX, y: -40)
        startGameLabel2.fontSize = 35
        startGameLabel2.text = "ball and make it crush the blocks "

        
        
        tapToPlay.position = CGPoint(x: self.frame.midX, y: -250)
        tapToPlay.fontSize = 45
        tapToPlay.text = "Tap the screen to start the game"
        
        addChild(titleLabel)
        addChild(titleLabel2)
        addChild(startGameLabel1)
        addChild(startGameLabel2)
        addChild(tapToPlay)
        
        
      
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startGame = Level1(fileNamed: "Level1")!
        startGame.scaleMode = .aspectFill
        self.view?.presentScene(startGame)
    }
    
}
