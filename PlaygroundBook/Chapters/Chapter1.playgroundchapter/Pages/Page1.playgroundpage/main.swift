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
//PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
/*:
 # Welcome to the Lightning Simulator
 This playground aims to make you discover how a lightning bolt works, by simulating lightning behaviour in different environments.
 As you can see, lightning will "search" for a path to go to the ground, by spliting itself into several branches.
 Once one of the branch hit the ground, the electrical discharge will go through this path.

 Try summonning lightning bolts by tapping on the screen (with finger or Apple Pencil), and see the bolt going to highest structures.

 This page is a sandbox. You can change the environment of the simulation by adding/removing elements, like [houses](glossary://house), [churches](glossary://church), [trees](glossary://trees) and [planes](glossary://plane). Elements will be [placed](glossary://placement) next to each other.

  * Note: The playground works well in side-to-side, but it is better in landscape & fullscreen mode.
---
*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, House(), Church(), Plane())
//#-code-completion(identifier, show, leafy, pine, random, .)
//#-code-completion(description, show, "Tree(type: TreeType)")

Simulation.build {
    // Add / Remove elements from the simulation here
    Church()
    House()
    House()
    House()
    
    Tree(type: .pine, x: 700)
}



/*:
*All credits for photos and textures can be found in the Playground credits*
*/
