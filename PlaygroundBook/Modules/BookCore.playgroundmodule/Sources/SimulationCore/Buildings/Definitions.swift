//
//  Definitions.swift
//  Lightning
//
//  Created by Maxime on 01/04/2021.
//

import Foundation
import SpriteKit
import CoreGraphics

public enum TreeType: Int {
    case leafy = 0
    case pine = 1
}

public class Building: SKShapeNode {
    
    static public var groundLevel: Int = 20
    static public var sceneSize: CGSize = .zero
    static public var lastPos: Int = 0
    
    
    var typeName: String = "building"
    var origin: CGPoint?
    var topPoints: [CGPoint] = []
    var width: Int = 0
    
    static public func church(x: Int = Building.lastPos + 5, y: Int = Building.groundLevel) -> Building {
        let origin = CGPoint(x: x, y: y)
        var points: [CGPoint] = [
            .init(x: origin.x + 0, y: origin.y + 0),
            .init(x: origin.x + 0, y: origin.y + 100),
            .init(x: origin.x + 140, y: origin.y + 100),
            .init(x: origin.x + 140, y: origin.y + 160),
            .init(x: origin.x + 170, y: origin.y + 260),
            .init(x: origin.x + 200, y: origin.y + 160),
            .init(x: origin.x + 200, y: origin.y + 0)
        ]
        
        let church = Building(points: &points, count: points.count)
        church.origin = origin
        church.width = 200
        church.typeName = "church"
        church.topPoints = [.init(x: origin.x + 170, y: origin.y + 260)]
        church.fillColor = .black
        church.strokeColor = .clear
        
        let supp1 = SKShapeNode(circleOfRadius: 20)
        supp1.position = .init(x: origin.x + 170, y: origin.y + 130)
        supp1.fillColor = .black
        supp1.strokeColor = .gray
        church.addChild(supp1)
        
        
        return church

    }
    
//    public func DestroyBuilding() {
//        let action = SKAction.sequence([
//            .move(to: .zero, duration: 0.5),
//            .removeFromParent(),
//        ])
//        self.removeFromParent()
//        self.run(action)
//    }
    
    
    static public func ground(height: Int = Building.groundLevel, width: Int = Int(max(UIScreen.main.bounds.width, UIScreen.main.bounds.height))) -> Building {
        let ground = Building(rect:
                                    CGRect(x: 0,
                                           y: 0,
                                           width: width,
                                           height: height)
                                )
        let h = Double(height)
        ground.topPoints = [
            .init(x: Double(width) * 0.25, y: h),
            .init(x: Double(width) * 0.5, y: h),
            .init(x: Double(width) * 0.75, y: h),
        ]
        
//        for _ in 0...5 {
//            let x = Int.random(in: 0...width)
//            let textureName = ["grass1", "grass2"].randomElement()!
//            let texture = SKTexture(imageNamed: textureName)
//            let node = SKSpriteNode.init(texture: texture)
//            ground.addChild(node)
//            node.position = .init(x: CGFloat(x), y: CGFloat(height))
//        }
        
        ground.typeName = "ground"
        ground.width = 0
        ground.fillColor = .black
        ground.strokeColor = .clear
        return ground
    }
    
    
    
    static public func house(x: Int = Building.lastPos + 5, y: Int = Building.groundLevel) -> Building {
        let origin = CGPoint(x: x, y: y)
        var points: [CGPoint] = [
            .init(x: origin.x + 0, y: origin.y + 0),
            .init(x: origin.x + 0, y: origin.y + 50),
            .init(x: origin.x + 25, y: origin.y + 80),
            .init(x: origin.x + 50, y: origin.y + 50),
            .init(x: origin.x + 50, y: origin.y + 0),
        ]
        
        let supplementals: [[CGPoint]] = [
            [
                .init(x: origin.x + 10, y: origin.y + 0),
                .init(x: origin.x + 10, y: origin.y + 20),
                .init(x: origin.x + 20, y: origin.y + 20),
                .init(x: origin.x + 20, y: origin.y + 0),
            ], [
                .init(x: origin.x + 20, y: origin.y + 40),
                .init(x: origin.x + 30, y: origin.y + 40),
                .init(x: origin.x + 30, y: origin.y + 50),
                .init(x: origin.x + 20, y: origin.y + 50),
                .init(x: origin.x + 20, y: origin.y + 40),
            ]
        ]
        
        let house = Building(points: &points, count: points.count)
        house.origin = origin
        house.width = 50
        house.typeName = "house"
        house.topPoints = [.init(x: origin.x + 25, y: origin.y + 80)]
        house.fillColor = .black
        house.strokeColor = .clear
        
        for supp in supplementals {
            var points = supp
            let suppNode = SKShapeNode(points: &points, count: supp.count)
            suppNode.fillColor = .black
            suppNode.strokeColor = .gray
            house.addChild(suppNode)
        }
        
        
        return house
    }
    
    static public func antenna(height: Int = 300, x: Int = Building.lastPos + 5, y: Int = Building.groundLevel) -> Building {
        let origin = CGPoint(x: x, y: y)
        var points: [CGPoint] = [
            .init(x: origin.x + 0, y: origin.y + 0),
            .init(x: origin.x + 10, y: origin.y + 10),
            .init(x: origin.x + 15, y: origin.y + CGFloat(height)),
            .init(x: origin.x + 20, y: origin.y + 10),
            .init(x: origin.x + 30, y: origin.y + 0),
        ]
        let antenna = Building(points: &points, count: points.count)
        antenna.origin = origin
        antenna.width = 30
        antenna.typeName = "antenna"
        antenna.topPoints = [.init(x: origin.x + 15, y: origin.y + CGFloat(height))]
        antenna.fillColor = .black
        antenna.strokeColor = .clear
        return antenna
    }
    
    static public func plane(x: Int = 300, y: Int = 100) -> Building {
        let origin = CGPoint(x: x, y: y)
        var points: [CGPoint] = [
            .init(x: origin.x + 0, y: origin.y + 30),
            .init(x: origin.x + 10, y: origin.y + 40),
            .init(x: origin.x + 10, y: origin.y + 50),
            .init(x: origin.x + 0, y: origin.y + 60),
            .init(x: origin.x + 05, y: origin.y + 60),
            .init(x: origin.x + 0, y: origin.y + 80),
            .init(x: origin.x + 10, y: origin.y + 80),
            .init(x: origin.x + 30, y: origin.y + 60),
    
            .init(x: origin.x + 70, y: origin.y + 60),
            .init(x: origin.x + 50, y: origin.y + 90),
            .init(x: origin.x + 60, y: origin.y + 90),
            .init(x: origin.x + 100, y: origin.y + 60),


            
            .init(x: origin.x + 130, y: origin.y + 60),
            //.init(x: origin.x + 150, y: origin.y + 40),
            
            .init(x: origin.x + 145, y: origin.y + 48),
            .init(x: origin.x + 147, y: origin.y + 46),
            .init(x: origin.x + 148, y: origin.y + 43),
            .init(x: origin.x + 145, y: origin.y + 40),
            
            .init(x: origin.x + 100, y: origin.y + 40),
            .init(x: origin.x + 60, y: origin.y + 0),
            .init(x: origin.x + 50, y: origin.y + 0),
            .init(x: origin.x + 70, y: origin.y + 40),

            
            
            .init(x: origin.x + 30, y: origin.y + 40),
            .init(x: origin.x + 10, y: origin.y + 30)
        ]
        
        let plane = Building(points: &points, count: points.count)
        plane.origin = origin
        plane.typeName = "plane"
        plane.width = 90
        //plane.topPoints = [.init(x: origin.x + 50, y: origin.y + 150)]
        plane.fillColor = .black
        plane.strokeColor = .clear
        return plane
    }
    
    static public func tree(type: TreeType, x: Int = Building.lastPos + 5, y: Int = Building.groundLevel) -> Building {
        if type == .pine {
            let origin = CGPoint(x: x, y: y)
            var points: [CGPoint] = [
                .init(x: origin.x + 40, y: origin.y + 0),
                .init(x: origin.x + 40, y: origin.y + 20),
                .init(x: origin.x + 10, y: origin.y + 20),
                .init(x: origin.x + 40, y: origin.y + 60),
                .init(x: origin.x + 20, y: origin.y + 60),
                .init(x: origin.x + 40, y: origin.y + 100),
                .init(x: origin.x + 28, y: origin.y + 100),
                .init(x: origin.x + 40, y: origin.y + 120),
                .init(x: origin.x + 34, y: origin.y + 120),
                .init(x: origin.x + 50, y: origin.y + 150),
                .init(x: origin.x + 66, y: origin.y + 120),
                .init(x: origin.x + 60, y: origin.y + 120),
                .init(x: origin.x + 72, y: origin.y + 100),
                .init(x: origin.x + 60, y: origin.y + 100),
                .init(x: origin.x + 80, y: origin.y + 60),
                .init(x: origin.x + 60, y: origin.y + 60),
                .init(x: origin.x + 90, y: origin.y + 20),
                .init(x: origin.x + 60, y: origin.y + 20),
                .init(x: origin.x + 60, y: origin.y + 0),
            ]
            let tree = Building(points: &points, count: points.count)
            tree.origin = origin
            tree.width = 90
            tree.typeName = "pine"
            tree.topPoints = [.init(x: origin.x + 50, y: origin.y + 150)]
            tree.fillColor = .black
            tree.strokeColor = .clear
            return tree
        } else {
            let origin = CGPoint(x: x, y: y)
            var points: [CGPoint] = [
                .init(x: origin.x + 40, y: origin.y + 0),
                .init(x: origin.x + 40, y: origin.y + 60),
                .init(x: origin.x + 60, y: origin.y + 60),
                .init(x: origin.x + 60, y: origin.y + 0),
                
                .init(x: origin.x + 90, y: origin.y - 1), // Required for tree width
            ]
            let tree = Building(points: &points, count: points.count)
            
            let circlesCenters: [CGPoint] = [
                .init(x: origin.x + 40, y: origin.y + 60),
                .init(x: origin.x + 60, y: origin.y + 60),
                .init(x: origin.x + 40, y: origin.y + 100),
                .init(x: origin.x + 30, y: origin.y + 80),
                .init(x: origin.x + 70, y: origin.y + 80),
                .init(x: origin.x + 60, y: origin.y + 100),
            ]
            
            for center in circlesCenters {
                let f1 = SKShapeNode(circleOfRadius: 20)
                f1.position = center
                f1.fillColor = .black
                f1.strokeColor = .clear
                tree.addChild(f1)
            }
            
            tree.origin = origin
            tree.width = 90
            tree.typeName = "leafy"
            tree.topPoints = [
                .init(x: origin.x + 40, y: origin.y + 120),
                .init(x: origin.x + 60, y: origin.y + 120)
            ]
            tree.fillColor = .black
            tree.strokeColor = .clear
            return tree
        }
        
    }
    
    
}

