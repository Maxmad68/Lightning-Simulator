//
//  AddBuilding.swift
//  Lightning
//
//  Created by Maxime on 01/04/2021.
//

import Foundation
import SpriteKit

extension SimulationScene {
    
    public func SetGround(height: Int) {
        Building.groundLevel = height
        self.Add(building: .ground(height: height))
    }
    
    public func Add(building: Building, animate: Bool = false) {
		building.zPosition = Layers.buildings.rawValue
        self.addChild(building)
        self.buildings.append(building)
        
//        if animate {
//            let fallAction = SKAction.moveTo(y: building.position.y, duration: 0.4)
//            fallAction.timingMode = .easeIn
//            let action = SKAction.sequence([
//                .moveTo(y: self.size.height, duration: 0),
//                fallAction
//            ])
//            building.run(action)
//        }
        
		if building.typeName != "ground" && building.typeName != "plane" {
            Building.lastPos = Int(building.frame.maxX) + 5
        }
        
    }
    
}
