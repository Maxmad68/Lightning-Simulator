//
//  DataDecoder.swift
//  BookCore
//
//  Created by Maxime on 11/04/2021.
//

import Foundation

/// Called by the liveview when it got a payload from main script.
/// Every item of the payload dict pass to this function, which adds the corresponding building
/// to the simulation.
///
/// - Parameters
///		data ([String: Int]) : Payload item for that building
///		scene: SimulationScene : The simulation scene
///
func AddBuilding(data: [String: Int], scene: SimulationScene) {
	let type = data["building"]
    // Ground
	if (type == 0) {
		let height = data["height"]!
        Building.groundLevel = height
        scene.Add(building: .ground(height: height))
    
    // House
	} else if (type == 1) {
        var x = Building.lastPos + 5
        if let dataX = data["x"] {
            if dataX == Int.random {
				if (Building.lastPos + 5 >= Int(scene.size.width)) {
					return
				}
                x = .random(in: (Building.lastPos + 5)...Int(scene.size.width))
            } else {
                x = dataX
            }
        }
        scene.Add(building: .house(x: x), animate: true)
      
    // Tree
	} else if (type == 2) {
        var x = Building.lastPos + 5
        if let dataX = data["x"] {
            if dataX == Int.random {
				if (Building.lastPos + 5 >= Int(scene.size.width)) {
					return
				}
                x = .random(in: (Building.lastPos + 5)...Int(scene.size.width))
            } else {
                x = dataX
            }
        }
        let type = data["tree"]!
        scene.Add(building: .tree(type: TreeType(rawValue: type)!, x: x), animate: true)
    
    // Church
	} else if (type == 3) {
        var x = Building.lastPos + 5
        if let dataX = data["x"] {
            if dataX == Int.random {
				if (Building.lastPos + 5 >= Int(scene.size.width)) {
					return
				}
                x = .random(in: (Building.lastPos + 5)...Int(scene.size.width))
            } else {
                x = dataX
            }
        }
        scene.Add(building: .church(x: x), animate: true)
    
    // Plane
    } else if (type == 4) {
        var x = Building.lastPos + 5
        if let dataX = data["x"] {
            if dataX == Int.random {
				x = .random(in: 0...Int(scene.size.width))
            } else {
                x = dataX
            }
        }
        let y = data["y"] ?? (Int(Building.sceneSize.height / 2) + Int.random(in: -150...150))
        
        scene.Add(building: .plane(x: x, y: y))
    }
}
