//
//  Rain.swift
//  PlaygroundBook
//
//  Created by Maxime on 10/04/2021.
//

import Foundation
import SpriteKit

/// Drop of rain. It will goes from top to bottom in loop.
class Droplet {
    var node: SKShapeNode
    var x: CGFloat
    var y: CGFloat
    var dx: CGFloat
    var speed: CGFloat
    
    var layer: RainLayer
    
    
    init(layer: RainLayer) {
        self.layer = layer
        
        self.node = SKShapeNode(rectOf: .init(width: 2, height: 20))
        self.node.fillColor = .lightGray
        self.node.strokeColor = .clear
        
        
        self.x = CGFloat.random(in: 0...layer.scene!.frame.size.width)
        self.y = CGFloat.random(in: 0...layer.scene!.frame.size.height)
        self.dx = CGFloat.random(in: -10...10)
        self.speed = CGFloat.random(in: 0.5...0.8)
        
        self.node.position = .init(x: self.x, y: self.y)
        
    }
    
    func getAnimation() -> SKAction {
        
        let animation = SKAction.repeatForever(.sequence([
            .move(to: .init(x: self.x + self.dx, y: 0), duration: TimeInterval(self.speed)),
            
            .moveTo(y: layer.scene!.frame.size.height, duration: 0),
            .moveTo(x: self.x, duration: 0)
        ]))
        return animation
    }
}

/// Layer node that will show rain-drops
class RainLayer: SKNode {
    
    var drops: [Droplet] = []
    
    
    override init() {
        super.init()
		self.zPosition = Layers.rain.rawValue
        //self.scene = scene
    }

    func animate() {
        for _ in 0...5 {
            let drop = Droplet(layer: self)
            self.drops.append(drop)
            self.addChild(drop.node)
        }
        
        for drop in self.drops {
            drop.node.run(drop.getAnimation())
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
