//
//  NextLevelScene.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-17.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import Foundation
import SpriteKit
import QuartzCore

class NextLevelScene: SKScene {
   

    var nice: SKLabelNode!
    var nextLevel : SKLabelNode!
    var scoreLabel : SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        nice = SKLabelNode(fontNamed: "Avenir-Black")
        nextLevel = SKLabelNode(fontNamed: "Avenir-Black")
        scoreLabel = SKLabelNode(fontNamed: "Avenir-Black")
        
        nice.position = CGPoint(x: self.frame.midX, y: 100)
        nice.fontSize = 80
        nice.fontColor = UIColor.green
        nice.text = "NICE WOORK!!"
        nice.run(blinkingLabel())
        addChild(nice)
        
        scoreLabel.position = CGPoint(x: self.frame.midX, y: -50)
        scoreLabel.fontSize = 55
        scoreLabel.fontColor = UIColor.white
        scoreLabel.text = "Score: \(Level1.score + 1)"
        addChild(scoreLabel)
        
        
        nextLevel.position = CGPoint(x: self.frame.midX, y: -200)
        nextLevel.fontSize = 40
        nextLevel.fontColor = UIColor.white
        nextLevel.text = "Tap the screen to continue to level 2"
        addChild(nextLevel)
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextLevel = Level2(fileNamed:"Level2")!
        nextLevel.scaleMode = .aspectFill
        self.view?.presentScene(nextLevel, transition: SKTransition.fade(with: UIColor.black, duration: 0.8))
    }
        
    func blinkingLabel() -> SKAction{
        let duration = 0.5
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 2.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
        
    }

}
    

