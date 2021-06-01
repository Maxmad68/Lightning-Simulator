//
//  SimulationScene.swift
//  Lightning
//
//  Created by Maxime on 02/04/2021.
//

import SpriteKit
import GameplayKit

public class SimulationScene: SKScene {
    
    // Effects variables
	public var enableRain = true
    public var enableBirds = true
    var birds: [Bird] = []
    
    var cloudsLayer: CloudLayer? = nil
    var rainLayer: RainLayer? = nil
    var stars: StarsLayer? = nil
    var moon: Moon? = nil
    var gradientNode: SKNode? = nil
    
    var soundManager: SoundManager
        
    // Simulation variables
    
    var timers: [Timer] = [] // List of all timers
    var matchingLines: [Line] = [] // Lines of neg trees to add in pos tree
	var highlightLines: [Line] = []
    
    var positive_tree: RRTree? = nil // Main tree going from top to bottom
    var negative_trees: [RRTree] = [] // Reversed trees going from buildings to top
    
    var iterationsPerFrame = 10
    
    var highestTop: CGFloat = 0
    
    // Keep all negative-trees lines in memory
    var reversedLines: [SKShapeNode] = []
    var reversedLinesInstances: [Line] = []
    
    var topPoints: [CGPoint] = [] // Highest points of every buildings
    var buildings: [Building] = [] // List of all buildings
    
    
    override public init(size: CGSize) {
        self.soundManager = SoundManager()
        
        super.init(size: size)
        
        self.size = size
        Building.sceneSize = size
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func didMove(to view: SKView) {
        //self.view?.preferredFramesPerSecond = 60 // DEBUG ONLY
        self.addChild(self.soundManager)
        self.soundManager.StartRainSound()
    }
    
    
    public override func didChangeSize(_ oldSize: CGSize) {
        Building.sceneSize = self.size
        
        if let rain = self.rainLayer {
            rain.removeFromParent()
        }
        if let clouds = self.cloudsLayer {
            clouds.removeFromParent()
        }
        if let gradient = self.gradientNode {
            gradient.removeFromParent()
        }
        if let moon = self.moon {
            moon.removeFromParent()
        }
        if let stars = self.stars {
            stars.removeFromParent()
        }

        
        // Make gradient background
        let startPoint = CGPoint(x: 0.5, y: 0)
        let endPoint = CGPoint(x: 0.5, y: 1)
        let image: UIImage = UIImage.gradientImage(withBounds: self.frame, startPoint: startPoint, endPoint: endPoint, colors: [#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)])
        let gradientTexture = SKTexture(image: image)
        self.gradientNode = SKSpriteNode(texture: gradientTexture)
		self.gradientNode!.zPosition = Layers.background.rawValue
        self.addChild(gradientNode!)
        self.gradientNode!.position = .init(x: (self.size.width/2), y: (self.size.height/2))
        
        
        // Make stars
        self.stars = StarsLayer(number_of_stars: 60)
        self.addChild(self.stars!)
        self.stars!.setup()
        
        // Make moon
        self.moon = Moon()
        self.addChild(moon!)
        moon!.position = .init(x: 100, y: self.size.height - 100)
        
        // Make rain
		if self.enableRain {
			self.rainLayer = RainLayer()
			self.addChild(self.rainLayer!)
			self.rainLayer!.animate()
		}
        
        // Make clouds
        self.cloudsLayer = CloudLayer()
        self.addChild(cloudsLayer!)
        cloudsLayer!.setup()
        
        
//        let zdot = SKShapeNode.init(circleOfRadius: 10)
//        zdot.fillColor = .red
//        zdot.strokeColor = .clear
//        zdot.position = .zero
//        self.addChild(zdot)
        
        
    }
    
  
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.timers.forEach {$0.invalidate()}
        
        let point = CGPoint(
            x: touches.first!.location(in: self).x,
            y: self.size.height
        )
        self.SummonBolt(on: point)
        
    }
    
    override public func update(_ currentTime: TimeInterval) {
        
		// Iterate trees
        if let tree = self.positive_tree {
            for _ in 0...self.iterationsPerFrame {
                tree.Iteration(simulation: self)
            }
        }
        
        for t in self.negative_trees {
            for _ in 0...self.iterationsPerFrame {
                t.Iteration(simulation: self)
            }
        }
        
		// Render lines
        for mLine in self.matchingLines.prefix(self.iterationsPerFrame) {
            self.matchingLines.removeFirst()
            mLine.node.isHidden = false
        }
		
		for hLine in self.highlightLines.prefix(self.iterationsPerFrame) {
			self.highlightLines.removeFirst()
			HighlightLine(hLine)
		}
		

        
        if self.enableBirds {
            if (Int.random(in: 0...700) == 0) {
                let bird = Bird()
                self.birds.append(bird)
                
                self.addChild(bird)
                bird.position = .init(x: -(bird.size.width * 1.5), y: self.size.height * .random(in: 0.2...1))
                bird.animate()
                
                let movement = SKAction.sequence([
                        .moveTo(x: self.size.width + (bird.size.width * 1.5), duration: .random(in: 2...4)),
                        .removeFromParent()
                    ])
                bird.run(movement)
            }
            
            var i = 0
            for bird in self.birds {
                if bird.parent == nil {
                    self.birds.remove(at: i)
                    i += 1
                    continue
                }
                
                if let tree = self.positive_tree {
                    for bolt in tree.lines {
                        if bolt.marked {
                            if bird.intersects(bolt.node) {
                                bird.fry()
                                self.birds.remove(at: i)
                                return
                            }
                        }
                    }
                }
                
                i += 1
            }
        }
        
        
        if Int.random(in: 0...350) == 0 && cloudsLayer != nil {
            cloudsLayer!.animateSmallClouds()
        }
    }
}
