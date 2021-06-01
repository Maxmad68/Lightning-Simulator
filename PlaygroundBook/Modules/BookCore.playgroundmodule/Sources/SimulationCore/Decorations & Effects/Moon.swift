//
//  Moon.swift
//  BookCore
//
//  Created by Maxime on 10/04/2021.
//

import Foundation
import SpriteKit

/// Moon node, that will be shown on the top-left corner.
/// Image is taken randomly from atlas
public class Moon: SKSpriteNode {
	
	// Choose image at beginning
	public static var atlas = SKTextureAtlas(named: "Moon")
	public static var image = atlas.textureNamed(atlas.textureNames.randomElement()!)
	
    public init() {
		super.init(texture: Moon.image, color: .clear, size: CGSize(width: 75, height: 75))
		self.zPosition = Layers.moon.rawValue
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
