//
//  StarsLayer.swift
//  PlaygroundBook
//
//  Created by Maxime on 15/04/2021.
//

import Foundation
import SpriteKit


class StarsLayer: SKNode {
    
    var stars: [SKShapeNode] = []
    var no_stars: Int
    
    init(number_of_stars: Int) {
        self.no_stars = number_of_stars

        super.init()
    }

    func setup() {
        for _ in 0...no_stars {
            let starNode = SKShapeNode(circleOfRadius: .random(in: 0.15...2))
            starNode.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            starNode.strokeColor = .clear
            starNode.position = CGPoint(
                x: .random(in: 0...self.scene!.size.width),
                y: self.scene!.size.height * .random(in: 0.2...1)
            )
			starNode.zPosition = Layers.stars.rawValue
            self.addChild(starNode)
            
            self.stars.append(starNode)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
