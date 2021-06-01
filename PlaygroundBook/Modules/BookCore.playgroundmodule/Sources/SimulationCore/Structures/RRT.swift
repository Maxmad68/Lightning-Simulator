//
//  RRT.swift
//  UserModule
//
//  Created by Maxime on 01/04/2021.
//

import SpriteKit
import GameplayKit

/// Structure representing the Rapidly-exploring Random Tree.
/// It contains numeric constants for the tree growing, instance of all lines,
/// and methods for building the tree
class RRTree {
    
    var active: Bool = true
    var iteration = 0
    
    var initialPoint: CGPoint
    
    var lines: [Line] = []
    var linesNodes: [SKShapeNode] = []
    
    var points: [CGPoint]
    
    var κ: CGFloat = 2
    var ε: CGFloat = 2.7
    var square_ε: CGFloat = 7.29 // ε^2
    
    var w: Int = 0
    var h: Int = 0
    
    init(initial: CGPoint) {
        self.initialPoint = initial
        points = [initial]
    }
    
    func reset(simulation: SimulationScene) {
        self.iteration = 0
        
        self.w = Int(simulation.size.width)
        self.h = Int(simulation.size.height)
        self.square_ε = CGFloat(self.ε * self.ε)
    }
    
    func Iteration(simulation: SimulationScene) {

        if !self.active {
            return
        }
            
        self.iteration += 1
        var parent: Line? = nil
        var nearestDistance: CGFloat = 0
        var nearest: CGPoint = self.points.first!
        var random: CGPoint = .zero
        
        var etapes = 0
        
        // Determine nearest node
        repeat {
            random = CGPoint(
                x: Int.random(in: 0...w),
                y: Int.random(in: 0...h)
            )
            
            nearestDistance = nearest.sqdistance(from: random)
            
            if self.lines.count > 1 {
                for i in 1...self.lines.count - 1 {
                    let d = self.lines[i].end.sqdistance(from: random)
                    if (d < nearestDistance) {
                        parent = self.lines[i]
                        nearest = parent!.end
                        nearestDistance = d
                    }
                }
            }
            
            etapes+=1
        } while (nearestDistance < square_ε)
            
            
        
        if nearestDistance >= square_ε {
            let node = self.step(a: nearest, b: random)
            self.points.append(node)
            
            let linenode = LineNode(start: nearest, end: node, width: 1)
            self.linesNodes.append(linenode)
            simulation.addChild(linenode)
            
            
            let lineInst = Line(node: linenode, start: nearest, end: node, parent: parent)
            self.lines.append(lineInst)
            
                            
            simulation.checkBuildingCollision(positiveLine: lineInst, node: node)
            
            
            if node.y <= simulation.highestTop {
                simulation.checkTreesCollision(positiveLine: lineInst)
            }
        }
        
        
    }
        
    func step(a: CGPoint, b: CGPoint) -> CGPoint {
        
        let θ = atan2(b.y - a.y, b.x - a.x)
        return CGPoint(
            x: a.x + ε * κ * cos(θ),
            y: a.y + ε * κ * sin(θ)
        )
    }
    
}
