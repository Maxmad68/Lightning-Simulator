//
//  SimuationMethods.swift
//  BookCore
//
//  Created by Maxime on 11/04/2021.
//

import Foundation
import UIKit

#if canImport(PlaygroundSupport)
import PlaygroundSupport
#endif

public var houseImage = UIImage(named: "house.png")!
public var leafyTreeImage = UIImage(named: "leafy.png")!
public var pineTreeImage = UIImage(named: "pine.png")!
public var churchImage = UIImage(named: "church.png")!
public var planeImage = UIImage(named: "plane.png")!

public class LiveViewSimulation {
    
    enum BuildingsTypes: Int {
        case ground = 0
        
        case house = 1
        case tree = 2
        case church = 3
        case plane = 4
    }
    
//    static var mainSimulation: LiveViewSimulation? = nil
    
    var payload: [[String: Int]] = []
    
    #if canImport(PlaygroundSupport)
    func send() {
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: self.payload)
            let data = PlaygroundValue.data(jsonData)
            if let liveView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy {
                liveView.send(data)
                //print (String(data: jsonData, encoding: .utf8))
            } else {
                print ("else")
            }
            
        } catch {
            print ("Can't send data to simulator")
            print (error.localizedDescription)
        }
    }
    #else
    func send() { print ("Not on playground")}
    #endif
    
    public func SetGround(height: Int) {
        self.payload.append(["building": BuildingsTypes.ground.rawValue, "height": height])
    }
    
    public func build(groundLevel: Int, buildFunction: () -> ()) {
        self.payload = []
        self.SetGround(height: groundLevel)
        buildFunction()
        self.send()
    }
    
    public func build(buildFunction: () -> ()) {
        self.build(groundLevel: 30, buildFunction: buildFunction)
    }
    
    public func immediateBuild(simulation: SimulationScene, groundLevel: Int = 30, buildFunction: () -> ()) { // Build from LiveView script
        self.payload = [["building": BuildingsTypes.ground.rawValue, "height": groundLevel]]
        buildFunction()
        for b in self.payload {
            AddBuilding(data: b, scene: simulation)
        }
        
        simulation.PrepareSimulator()
        simulation.BuildNegativeTrees()
    }
    
}


public var Simulation = LiveViewSimulation()

public func House() -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.house.rawValue]
    addToSimulator(dict)
    return houseImage
}
public func House(x: Int) -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.house.rawValue, "x": x]
    addToSimulator(dict)
    return houseImage
}

public func Tree(type: TreeType) -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.tree.rawValue, "tree": type.rawValue]
    addToSimulator(dict)
    return (type == .leafy) ? leafyTreeImage : pineTreeImage
    
}
public func Tree(type: TreeType, x: Int) -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.tree.rawValue, "x": x, "tree": type.rawValue]
    addToSimulator(dict)
    return (type == .leafy) ? leafyTreeImage : pineTreeImage
}

public func Church() -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.church.rawValue]
    addToSimulator(dict)
    return churchImage
}
public func Church(x: Int) -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.church.rawValue, "x": x]
    addToSimulator(dict)
    return churchImage
}

public func Plane(x: Int = 300) -> UIImage {
    let dict = ["building": LiveViewSimulation.BuildingsTypes.plane.rawValue, "x": x]
    addToSimulator(dict)
    return planeImage
}
public func Plane(altitude: Int, x: Int = 300) -> UIImage {
	let dict = ["building": LiveViewSimulation.BuildingsTypes.plane.rawValue, "x": x, "y": altitude]
	addToSimulator(dict)
	return planeImage
}



public func addToSimulator(_ dict: [String: Int]) {
    Simulation.payload.append(dict)
}
