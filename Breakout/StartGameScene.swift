//
//  StartGameScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-12.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit
import QuartzCore

class StartGameScene: SKScene {
    // Main menu, need to figure out how to make a scene the starting scene.
    
    override func didMove(to view: SKView) {
        
    
        let titleLabel = SKLabelNode(fontNamed: "Avenir-Black")
        let titleLabel2 = SKLabelNode(fontNamed: "Avenir-Black")
        let startGameLabel1 = SKLabelNode(fontNamed: "Avenir-Black")
        let startGameLabel2 = SKLabelNode(fontNamed: "Avenir-Black")
        let tapToPlay = SKLabelNode(fontNamed: "Avenir-Black")
        
        self.backgroundColor = UIColor.black
        
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
        let startGame = GameScene(fileNamed: "GameScene")!
        startGame.scaleMode = .aspectFill
        self.view?.presentScene(startGame)
    }
    
}
