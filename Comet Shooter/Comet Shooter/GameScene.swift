//
//  GameScene.swift
//  Comet Shooter
//
//  Created by Akash Bhandari on 4/6/16.
//  Copyright (c) 2016 Akash Bhandari. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
     var player = SKSpriteNode (imageNamed: "player.png")
    
    override func didMoveToView(view: SKView) {
        //location of player and adding player to the scene
        
        //backgroundColor = SKColor.blackColor() // red color background
        
        let backgroundImage = SKSpriteNode (imageNamed: "EarthSide.jpg")
        backgroundImage.zPosition = -10
        backgroundImage.size = frame.size
        backgroundImage.alpha = 0.80
        backgroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        addChild(backgroundImage)
        
        player.position = CGPointMake(self.size.width / 2, self.size.height / 6)
        
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "spawnBullets", userInfo: nil, repeats: true)
        
        var enemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "spawnEnemy", userInfo: nil, repeats: true)
        
        self.addChild(player)
    }
    
    func spawnBullets () {
        
        var bullets = SKSpriteNode (imageNamed: "bullet.png")
        
        bullets.zPosition = -5
        bullets.position = CGPointMake(player.position.x, player.position.y)
        
        let action = SKAction.moveToY(self.size.height + 30, duration: 1.0)
        bullets.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(bullets)
    }
    
    func spawnEnemy () {
        var cometEnemy = SKSpriteNode (imageNamed: "enemy.png")
        
        var minValue = self.size.width / 8
        var maxValue = self.size.width - 10
        var spawnPoint = UInt32(maxValue - minValue)
        
        cometEnemy.position = CGPointMake(CGFloat(arc4random_uniform(spawnPoint)), self.size.height)
        
        let action = SKAction.moveToY(-70, duration: 2.0)
        cometEnemy.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(cometEnemy)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

/// ask about the pos of functions and use of ()
