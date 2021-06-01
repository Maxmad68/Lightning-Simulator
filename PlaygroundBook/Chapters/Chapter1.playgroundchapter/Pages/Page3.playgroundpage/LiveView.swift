//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//



import BookCore
import PlaygroundSupport
import SpriteKit

let vc = instantiateLiveView(with: "LiveView") as! SimulationViewController
PlaygroundPage.current.liveView = vc



Simulation.immediateBuild(simulation: vc.scene!, groundLevel: 30) {
    Plane(altitude: 400, x: 300)
    Tree(type: .leafy, x: 400)
}
