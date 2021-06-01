//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//



import BookCore
import PlaygroundSupport
import SpriteKit

//PlaygroundPage.current.wantsFullScreenLiveView = true // Full screen




//#-code-completion(everything, hide)
//#-code-completion(identifier, show, Plane(), random, .)
//#-code-completion(description, show, "Plane(altitude: Int)", "Plane(x: Int)", "Plane(x: Int, altitude: Int)")


//#-end-hidden-code

/*:
# When lightning meets airplanes

 * Experiment: With the [`Plane()`](glossary://plane) element, try summoning bolts and see what happens when they meet an airplane

**Please disable "Show Results" to play with the simulator**
---
*/

Simulation.build {
	Plane(altitude: /*#-editable-code Altitude*/400/*#-end-editable-code*/, x: /*#-editable-code Position*/300/*#-end-editable-code*/)
    Tree(type: /*#-editable-code Tree type*/.leafy/*#-end-editable-code*/, x: /*#-editable-code Position*/400/*#-end-editable-code*/)
}

/*:
 An airplane act as a Faraday Cage. It means the inside of the plane is totally isolated from the electomagnetics fields generated outside. Passengers and all equipments are totally safe.
 To help lightnings finding their way through the aircraft, it has been designed to facilitate the conduction of the electricity to the tail or the wings.
 On average, every passenger airplane is stuck by a lightning about once a year.

![Airplane stuck by lightning](lightningAirplane.png)
*/

