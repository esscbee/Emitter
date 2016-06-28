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
                var frame = c.frame
                if frame.width == 0 || frame.height == 0 {
                    if let emitter = c as? SKEmitterNode {
                        if false {
                            let ppr = emitter.particlePositionRange
                            frame.size.width = frame.origin.x - ppr.dx
                            frame.size.height = frame.origin.y - ppr.dy
                        } else {
                            frame = emitter.calculateAccumulatedFrame()
                        }
                    }
                }
                if(CGRectContainsPoint(frame, location)) {
                    toDelete.append(c)
                    found = true
                    print("Deleting \(c)")
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
        
        
        var maybeNode : SKNode?
            
        if false {
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            sprite.runAction(SKAction.repeatActionForever(action))
            maybeNode = sprite
        } else {
            let particles = ["Rain", "Magic", "Fire", "Bokeh", "Snow"]
            let idx = random() % particles.count
            let particle = particles[idx]
            let path = NSBundle.mainBundle().pathForResource(particle, ofType: "sks")
            let emitter = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode

//            print(emitter)
            maybeNode = emitter
        }
        
        if let sprite = maybeNode {
            sprite.position = location
            self.addChild(sprite)
        }
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
