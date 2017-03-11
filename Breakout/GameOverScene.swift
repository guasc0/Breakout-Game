//
//  GameOverScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-11.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, playerWon: Bool) {
        super.init(size: size)
    
        let gameOverLabel = SKLabelNode(fontNamed: "Avenir-Black")
        let playAgainLabel = SKLabelNode(fontNamed: "Avenir-Black")
        self.backgroundColor = UIColor.black
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        playAgainLabel.position = CGPoint(x: self.frame.midX, y: 500)
        playAgainLabel.fontSize = 40
        playAgainLabel.fontColor = UIColor.white
        playAgainLabel.text = "Tap the screen to play again"
        addChild(playAgainLabel)
        
        
        
        if playerWon {
            gameOverLabel.fontSize = 107
            gameOverLabel.fontColor = UIColor.green
            gameOverLabel.text = "YOU WON"
        } else {
            gameOverLabel.fontSize = 98
            gameOverLabel.fontColor = UIColor.red
            gameOverLabel.text = "GAME OVER"
        }
        
        addChild(gameOverLabel)
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let backToGame = GameScene(size: self.size)
        self.view?.presentScene(backToGame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
