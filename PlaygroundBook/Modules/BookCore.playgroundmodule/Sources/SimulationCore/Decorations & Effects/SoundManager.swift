//
//  SoundManager.swift
//  BookCore
//
//  Created by Maxime on 14/04/2021.
//

import Foundation
import SpriteKit

/// Node that has no appearance, that will care of playing ambiant sounds.
/// Rain sound and thunder sound are played by this object.
/// Chicken sound are played by the respective Bird instance and NOT BY SOUNDMANAGER
///
class SoundManager: SKNode {
    
    var rainSoundAction: SKAction
    var oldThunderSound = ""
    
    override init() {
        // Get rain sound so it will be ready to play when required
        self.rainSoundAction = SKAction.repeatForever(.playSoundFileNamed("rain.wav", waitForCompletion: true))

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Start playing the rain ambiant sound, in loop
    func StartRainSound() {
        self.run(self.rainSoundAction)
    }
    
    /// Play a thunder sound, randomly but not the same as the last one
    func ThunderSound() {
        var soundName = ""
        repeat {
            soundName = ["thunder1.wav", "thunder2.wav", "thunder3.wav"].randomElement()!
        } while soundName == self.oldThunderSound
		self.oldThunderSound = soundName
        let action = SKAction.playSoundFileNamed(soundName, waitForCompletion: false)
        self.run(action)
    }
    
}
