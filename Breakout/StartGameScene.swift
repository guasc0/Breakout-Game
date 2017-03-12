//
//  StartGameScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-12.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit

class StartGameScene: SKScene {
    // Main menu, need to figure out how to make a scene the starting scene.
    
    
    override func didMove(to view: SKView) {
        
        let titleLabel = SKLabelNode(fontNamed: "Avenir-Black")
        let startGameLabel1 = SKLabelNode(fontNamed: "Avenir-Black")
        let startGameLabel2 = SKLabelNode(fontNamed: "Avenir-Black")
        let tapToPlay = SKLabelNode(fontNamed: "Avenir-Black")
        
        self.backgroundColor = UIColor.black
        
        titleLabel.position = CGPoint(x: self.frame.midX, y: 900)
        titleLabel.fontSize = 80
        titleLabel.fontColor = UIColor.blue
        titleLabel.text = "BLOCK CRUSHER"
        
        startGameLabel1.position = CGPoint(x: self.frame.midX, y: 700)
        startGameLabel1.fontSize = 35
        startGameLabel1.text = "Move the paddle sideways to hit the "
        
        startGameLabel2.position = CGPoint(x: self.frame.midX, y: 660)
        startGameLabel2.fontSize = 35
        startGameLabel2.text = "ball and make it crush the blocks "

        
        
        tapToPlay.position = CGPoint(x: self.frame.midX, y: 400)
        tapToPlay.fontSize = 45
        tapToPlay.text = "Tap the screen to start the game"
        
        addChild(titleLabel)
        addChild(startGameLabel1)
        addChild(startGameLabel2)
        addChild(tapToPlay)
    }
    
    
        
        
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startGame = GameScene(size: self.size)
        self.view?.presentScene(startGame)
    }
    
    

}
