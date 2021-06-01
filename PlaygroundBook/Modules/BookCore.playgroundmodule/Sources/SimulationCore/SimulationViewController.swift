//
//  SimulationViewController.swift
//  Lightning
//
//  Created by Maxime on 01/04/2021.
//

import UIKit
#if canImport(PlaygroundSupport)
import PlaygroundSupport
#endif
import SpriteKit
import GameplayKit

public class SimulationViewController: UIViewController {
        
    @IBOutlet var skView: SKView!
    public var scene: SimulationScene? = nil
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        

        self.scene = SimulationScene(size: self.view.bounds.size)
        skView.presentScene(scene!)
        skView.contentMode = .right
        self.scene!.scaleMode = .resizeFill
        self.scene!.iterationsPerFrame = 5
        self.skView.preferredFramesPerSecond = 60
                
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        
        #if !canImport(PlaygroundSupport)
        Simulation.immediateBuild(simulation: self.scene!, groundLevel: 30) {
            Church()
            House()
            House()
            House()

            Tree(type: .pine, x: 700)
        }

        #endif
        
//        }
    }
    
    override public var shouldAutorotate: Bool {
        return true
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
}


#if canImport(PlaygroundSupport)
extension SimulationViewController: PlaygroundLiveViewMessageHandler {
    
    public func receive(_ message: PlaygroundValue) {
        
        switch message {
            
            case .data(let value):
                do {
                    let d = try JSONSerialization.jsonObject(with: value, options: []) as! [[String: Int]]
                    
                    for b in self.scene!.buildings {
                        //b.DestroyBuilding()
                        b.removeFromParent()
                    }
                    scene!.buildings = []

                    Building.lastPos = 0
                    for b in d {
                        AddBuilding(data: b, scene: scene!)
                    }
                    
                    scene!.PrepareSimulator()
                    scene!.BuildNegativeTrees()
                } catch {
                    print(error.localizedDescription)
                }
                
            default:
                break
        }
    }
}
#endif
