//
//  Bolt Generation.swift
//  BookCore
//
//  Created by Maxime on 14/04/2021.
//

import SpriteKit

extension SimulationScene {
    ///
    /// Prepare simulation by finding top-points of every buildings
    ///
    func PrepareSimulator() {
        self.topPoints = []
        for b in buildings {
            self.topPoints.append(contentsOf: b.topPoints)
        }
    }
    
    ///
    /// Called when thunder has struck.
    /// This will play the thunder sound, and start fading-out the bolt
    ///
    func Thunder() {
        // Play sound
        self.soundManager.ThunderSound()
        
        // Fade-out
        if let tree = self.positive_tree {
            let fadeOutAction = SKAction.sequence([
                .wait(forDuration: 1),
                .fadeOut(withDuration: 3),
                .removeFromParent(),
                .run{tree.lines = []; tree.linesNodes = [];}
            ])

			for l in tree.linesNodes {
                l.run(fadeOutAction)
            }
        }
    }
    
    ///
    /// Highlight the path of lightning from specified line
    ///
    func HighlightBolt(_ line: Line) {
//        HighlightLine(line)
		self.highlightLines.append(line)
		
        if line.parent != nil {
            //Timer.scheduledTimer(withTimeInterval: 0.002, repeats: false) { _ in
                self.HighlightBolt(line.parent!)
            
        }
    }
	
	func HighlightLine(_ line: Line) {
		line.marked = true
		line.node.strokeColor = .yellow
		line.node.lineWidth = 3
		line.node.lineJoin = .miter
		line.node.lineCap = .butt
//		if line.node.parent == nil && !line.hidden {
//			self.addChild(line.node)
//		}
	}
    
    ///
    /// Summon a positive bolt at specific point
    ///
    /// - Parameters:
    ///    on (CGPoint) : Initial root point of the bolt
    ///
    func SummonBolt(on point: CGPoint) {
        // Remove existing positive tree
        self.positive_tree?.active = false

        if let tree = self.positive_tree {
            tree.linesNodes.forEach{$0.removeFromParent()}
            tree.linesNodes = []

            tree.lines = []
        }
   
        // Create new tree
        
        let tree = RRTree(initial: point)
        self.positive_tree = tree
        tree.reset(simulation: self)
        
    }
    
    ///
    /// Check if a line for a node is colliding with a building.
    /// If it's the case, stop the tree from expanding.
    /// If touched building is a plane, make the tree continue from plane exit point.
    ///
    /// - Parameters:
    ///    positiveLine (Line) : Line to test
    ///    node (CGPoint) : Node to test
    ///
    func checkBuildingCollision(positiveLine line: Line, node: CGPoint) {
        
        for b in self.buildings {
            if b.contains(node) {
                
                if b.typeName == "plane" { // Touching a plane
                    let exitPoint = CGPoint(x: b.origin!.x + 55, y: b.origin!.y + 0)
                    self.positive_tree?.points.append(exitPoint)
                    
                    let addLineNode = LineNode(start: line.end, end: exitPoint, width: 1)
                    let addLine = Line(node: addLineNode, start: line.end, end: exitPoint, parent: line)
                    addLine.hidden = true
                    
                    self.positive_tree?.lines.append(addLine)
                    self.positive_tree?.linesNodes.append(addLineNode)
                    
                } else {
                    
                    self.HighlightBolt(line)
                    self.Thunder()
                    self.positive_tree?.active = false
                    return
                }
            }
        }
    }
    
    ///
    /// Check if a line is colliding with a negative-tree.
    /// If it's the case, stop the tree from expanding, and link the tree to root of the negative tree
    ///
    /// - Parameters:
    ///     positiveLine (Line) : Line to test
    ////
    func checkTreesCollision(positiveLine line: Line) {
        for n in self.reversedLinesInstances {
            if n.node.intersects(line.node) {
                
                var addLineNode = LineNode(start: n.end, end: line.end, width: 1)
                var addLine = Line(node: addLineNode, start: n.end, end: line.end, parent: line)
                self.addChild(addLineNode)
                self.positive_tree?.lines.append(addLine)
                self.positive_tree?.linesNodes.append(addLineNode)
                
                var line: Line? = n
                while (line != nil) {
                    addLineNode = LineNode(start: line!.end, end: line!.start, width: 1)
                    addLine = Line(node: addLineNode, start: line!.end, end: line!.start, parent: addLine)
                    if (!line!.hidden) {
                        self.addChild(addLineNode)
                        addLineNode.isHidden = true
                    }
                    self.positive_tree?.lines.append(addLine)
                    self.positive_tree?.linesNodes.append(addLineNode)
                    self.matchingLines.append(addLine)
                    line = line!.parent
                }
                
                HighlightBolt(addLine)
                Thunder()
                positive_tree?.active = false
                return
            }
        }
    }
    
    
    ///
    /// Start negative trees from buildings top points
    ///
    public func BuildNegativeTrees() {
        reversedLines.forEach{$0.removeFromParent()}
        reversedLines = []
        reversedLinesInstances = []
        
        for t in self.topPoints {
            let tree = NegativeRRTree(initial: t)
            tree.active = true
            self.negative_trees.append(tree)
        }
    }
    
}
