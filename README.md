# Lightning-Simulator
My Playground for the WWDC Swift Student Challenge 2021 [Accepted ✅]

See "Release" tab to download directly on iPad 👆

My Playground is a Lightning simulator. By tapping on the screen, you can summon lightning bolts, and see how they will react in different environments.
You can add different buildings by editing the code on the left panel.

### Buildings:

* `Church()`
* `House()`
* `Tree(type: .leafy)`
* `Tree(type: .pine)`
* `Plane()`

Lightning bolts are simulated using Randomly-exploring Random Trees (RRT).
RRT is a path-finding algorithm, using a tree structure to search through a big space of finite dimension.
Basically, this algorithm consists of letting a tree grow from source point, put some nodes randomly near the tree, adding them to the tree and repeat until the tree hits the destination point.

*But why using a path-finding algorithm to simulate lightning bolts?*<br>
When we think about it, lightning can be imagined as some kind of maze, in which the bolt enters from the cloud (where it is formed), and exits by one of the highest point of some buildings or trees on the ground.

![With editor](https://madrau.fr/WWDC-Github/21-screen1.PNG)
![Fullscreen](https://madrau.fr/WWDC-Github/21-screen2.PNG)