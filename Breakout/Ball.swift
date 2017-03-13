//
//  Ball.swift
//  Breakout
//
//  Created by Gualberto Scolari on 2017-03-11.
//  Copyright © 2017 Gualberto Scolari. All rights reserved.
//

import Foundation
import SpriteKit

class Ball {

    let sprite : SKSpriteNode
    var direction : Float = Float.pi * 0.5
    var speed : Float = 600
    
    init(sprite: SKSpriteNode) {
        self.sprite = sprite
    }
    
    func update(deltaTime: Float) {
        let pos = sprite.position
        let newX = Float(pos.x) + cosf(direction) * speed * deltaTime
        let newY = Float(pos.y) + sinf(direction) * speed * deltaTime
        sprite.position = CGPoint(x: CGFloat(newX), y: CGFloat(newY))
        
        
    }
}
