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
        addChild(gameOverLabel)
        
        
        if playerWon {
            gameOverLabel.fontSize = 107
            gameOverLabel.fontColor = UIColor.green
            gameOverLabel.text = "YOU WON"
            gameOverLabel.run(blinkingLabel())
        } else {
            gameOverLabel.fontSize = 98
            gameOverLabel.fontColor = UIColor.red
            gameOverLabel.text = "GAME OVER"
            gameOverLabel.run(blinkingLabel())
        }
        
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let backToGame = GameScene(fileNamed:"GameScene")!
        backToGame.scaleMode = .aspectFill
        self.view?.presentScene(backToGame, transition: SKTransition.fade(with: UIColor.red, duration: 0.8))
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func blinkingLabel() -> SKAction{
        let duration = 0.5
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 2.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
        
    }

}
