//
//  Bird.swift
//  PlaygroundBook
//
//  Created by Maxime on 10/04/2021.
//

import Foundation
import SpriteKit

/// Decorative node, representing a bird going from left to right.
class Bird: SKSpriteNode {
    
    var frames = [SKTexture]()
    
    init() {
        let atlas = SKTextureAtlas(named: "Bird")
        
        let numImages = atlas.textureNames.count
        for i in 1...numImages {
            let name = "bird\(i)"
            self.frames.append(atlas.textureNamed(name))
        }
                
        super.init(texture: self.frames[0], color: .black, size: .init(width: 50, height: 50))
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.velocity = .init(dx: 10, dy: 0)
        self.physicsBody?.affectedByGravity = false
		self.zPosition = Layers.birds.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animate() {
        self.run(SKAction.repeatForever(
                    SKAction.animate(with: self.frames,
                                     timePerFrame: 0.05,
                                     resize: false,
                                     restore: true)),
                 withKey:"walkingInPlaceBear")
    }
    
    func fry() {
        self.removeAllActions()
        self.run(.playSoundFileNamed("chicken.wav", waitForCompletion: false))
        self.texture = SKTexture(imageNamed: "chicken.png")
        self.physicsBody!.affectedByGravity = true
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.mass = 1
    }
}
