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
        let scoreLabel = SKLabelNode(fontNamed: "Avenir-Black")
        self.backgroundColor = UIColor.black
        
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: 800)
        
        scoreLabel.position = CGPoint(x: self.frame.midX, y: 600)
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = UIColor.white
        
        
        playAgainLabel.position = CGPoint(x: self.frame.midX, y: 500)
        playAgainLabel.fontSize = 40
        playAgainLabel.fontColor = UIColor.white
        playAgainLabel.text = "Tap the screen to play again"
        
        addChild(scoreLabel)
        addChild(playAgainLabel)
        addChild(gameOverLabel)
        
        
        if playerWon {
            gameOverLabel.fontSize = 107
            gameOverLabel.fontColor = UIColor.green
            gameOverLabel.text = "YOU WON"
            scoreLabel.text = "Your score: \(Level1.score + 1)"
            gameOverLabel.run(blinkingLabel())
        } else {
            gameOverLabel.fontSize = 98
            gameOverLabel.fontColor = UIColor.red
            gameOverLabel.text = "GAME OVER"
            scoreLabel.text = "Your score: \(Level1.score)"
            gameOverLabel.run(blinkingLabel())
        }
        
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let backToGame = Level1(fileNamed:"Level1")!
        backToGame.scaleMode = .aspectFill
        self.view?.presentScene(backToGame, transition: SKTransition.fade(with: UIColor.black, duration: 0.8))
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
