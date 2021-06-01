//
//  Reversed RRT.swift
//  BookCore
//
//  Created by Maxime on 12/04/2021.
//

import Foundation
import CoreGraphics

/// Subclass of the RRT for negative tree (from bottom to top)
///
class NegativeRRTree: RRTree {
    
    override func Iteration(simulation: SimulationScene) {
        
        if !self.active {
            return
        }
        
        self.iteration += 1
                
                
        
        var parent: Line? = nil
        var nearestDistance: CGFloat = 0
        var nearest: CGPoint = self.points.first!
        var random: CGPoint = .zero
        
        
        repeat {
            random = CGPoint(
                x: Int.random(in: Int(self.initialPoint.x) - 200...Int(self.initialPoint.x) + 200),
                y: Int.random(in: Int(self.initialPoint.y)...Int(self.initialPoint.y) + 200)
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
            
        } while (nearestDistance < square_ε)
        
        
        
        
        
        if nearestDistance >= self.square_ε {
            let node = self.step(a: nearest, b: random)
            self.points.append(node)

            if node.y > simulation.highestTop {
                simulation.highestTop = node.y
            }
            
            let linenode = LineNode(start: nearest, end: node, width: 1)
            self.linesNodes.append(linenode)
            simulation.reversedLines.append(linenode)
            
            linenode.strokeColor = .blue
            //simulation.addChild(linenode)
            
            
            let lineInst = Line(node: linenode, start: nearest, end: node, parent: parent)
            simulation.reversedLinesInstances.append(lineInst)
            self.lines.append(lineInst)
            
        }
            
        if self.iteration > 500 {
            self.active = false
            return
        }
                

        
    }
}
