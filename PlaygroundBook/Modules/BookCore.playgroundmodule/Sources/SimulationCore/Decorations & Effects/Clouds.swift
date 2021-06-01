//
//  Clouds.swift
//  PlaygroundBook
//
//  Created by Maxime on 10/04/2021.
//

import Foundation
import SpriteKit

/// Layer node that will show clouds.
/// It will contain a big cloud, that will fill the entire width, and small clouds that will appear at some random times.
/// All type of clouds go from right to left to imitate wind effect
///
class CloudLayer: SKNode {
    
    var texture: SKTexture
    var nodes = [SKSpriteNode]()
    
    var cloudSpeed = 35 // Animation duration
    
    override init() {
        let cloudName = ["clouds1.png", "clouds2.png"].randomElement()
        self.texture = SKTexture(imageNamed: cloudName!)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
		let width = self.texture.size().width - 1
		let noImages = Int(self.scene!.size.width / width) + 2
		
		for step in 0...noImages {
			print(step)
			let cloudNode = SKSpriteNode(texture: texture, color: .init(white: 0, alpha: 0.3), size: texture.size())
			cloudNode.zPosition = Layers.rain.rawValue
			cloudNode.zRotation = .pi
			cloudNode.position = .init(x: width * CGFloat(step), y: self.scene!.size.height)
			cloudNode.alpha = 0.3
			self.addChild(cloudNode)
			self.nodes.append(cloudNode)
			
			let cloudAnimation = SKAction.repeatForever(.sequence([
				.moveBy(x: -width, y: 0, duration: TimeInterval(self.cloudSpeed)),
				.moveBy(x: width, y: 0, duration: 0)
				
			]))
			cloudNode.run(cloudAnimation)
		}
        
    }
    
    func animateSmallClouds() {
        let cloudName = ["cloud1.png", "cloud2.png", "cloud3.png"].randomElement()
        let texture = SKTexture(imageNamed: cloudName!)
        let cloudNode = SKSpriteNode.init(texture: texture, color: .init(white: 0, alpha: 0.3), size: texture.size())
        cloudNode.alpha = 0.6
		cloudNode.zPosition = Layers.rain.rawValue
        cloudNode.position = .init(
            x: self.scene!.size.width + texture.size().width * 1.75,
            y: self.scene!.size.height - texture.size().height * .random(in: 0.5...1.2)
        )
        
        let dur = TimeInterval(Float(self.cloudSpeed) * Float.random(in: 0.5...1.5))
        
        let animation = SKAction.sequence([
            SKAction.moveTo(x: texture.size().width * -1.25, duration: dur),
            .removeFromParent()
        ])
        
        self.addChild(cloudNode)
        cloudNode.run(animation)
    }
    
}

