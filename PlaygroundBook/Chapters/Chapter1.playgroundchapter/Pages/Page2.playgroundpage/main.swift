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
//#-code-completion(identifier, show, leafy, pine, random, .)

//#-end-hidden-code

/*:
# Don't stay under a tree!

 * Experiment: Try summoning bolts at different places on the simulation, and see what happens to a tree alone in a thunderstorm. Why is it a bad idea to shelter under a tree?

**Please disable "Show Results" to play with the simulator**
---
*/

Simulation.build {
	Tree(type: /*#-editable-code Type*/.pine/*#-end-editable-code*/, x: /*#-editable-code Position*/.random/*#-end-editable-code*/)
}

/*:
 Standing under a tree is probably the worst place to be in a thunderstorm.
 Lightning bolts are caused by a difference of electric potential between the ground and the clouds.
 Then, a gigantic sparkle will be formed between them. But, the air between the ground and the sky has a high electric resistance.
 So, the sparkle will go through everything in contact with the ground, to travel across less air.

 That's why lightning bolts usually strike highest points.
 Trees are no exceptions; as you can experiment on this page, the bolt will most of the time strike the tree, no matter where it is.
*/


