//
//  GameScene.swift
//  Emitter
//
//  Created by Stephen Brennan on 6/28/16.
//  Copyright (c) 2016 Stephen Brennan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        reset()
    }
    
    func reset() {
        self.removeAllChildren()
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Where there's smoke"
        myLabel.fontSize = 32
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        var toDelete = [SKNode]()
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            var found = false
            for c in self.children {
                if(CGRectContainsPoint(c.frame, location)) {
                    toDelete.append(c)
                    found = true
                }
            }
            if found {
                continue
            }
            
            addNodeAt(location)
        }
        self.removeChildrenInArray(toDelete)
    }
    func addNodeAt(location : CGPoint) {
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = location
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
