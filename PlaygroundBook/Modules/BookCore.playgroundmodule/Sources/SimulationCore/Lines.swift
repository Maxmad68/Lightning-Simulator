//
//  Lines.swift
//  BookCore
//
//  Created by Maxime on 14/04/2021.
//

import Foundation
import SpriteKit

class Line {
    /// Represents a single Line of the tree and its parent (if it has one)
    ///
    var node: SKShapeNode!
    var start: CGPoint!
    var end: CGPoint!
    var hidden = false
    var marked = false
    var parent: Line? = nil
    
    init(node: SKShapeNode, start: CGPoint, end: CGPoint, parent: Line? = nil) {
        self.node = node
        self.start = start
        self.end = end
        self.parent = parent
    }
}

func LineNode(start startPoint: CGPoint, end endPoint: CGPoint, width: Double) -> SKShapeNode {
    // Create line with SKShapeNode
    let line = SKShapeNode()
    let path = UIBezierPath()
    path.move(to: startPoint)
    path.addLine(to: endPoint)
    line.path = path.cgPath
    line.strokeColor = UIColor.white
    //print (width)
    line.lineWidth = CGFloat(0.5)
    
    return line
}
