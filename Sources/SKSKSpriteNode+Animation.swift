//
//  SKSKSpriteNode+Animation.swift
//  SpriteSwift
//
//  Created by Daniel Lin on 2020/7/9.
//  Copyright © 2020 dklinzh. All rights reserved.
//

import SpriteKit

/// Generate an array of SKTexture instances for an animation.
/// - Parameters:
///   - atlas: The texture atlas in which the frame textures for the animations are contained, or nil if no texture atlas is used.
///   - animationName: The name of the animation.
///   - numberOfFrames: The number of frames that the animation has.
/// - Returns: An array of SKTexture instances for an animation. This function assumes that the frame textures are named according to the following convention; <animationName>-<frameNumber>. So for an animation called "attack", which has 2 frames, the frame textures would be called "attack-0" and "attack-1".
public func SSAnimationTextures(atlas: SKTextureAtlas?, animationName: String, numberOfFrames: UInt) -> [SKTexture]? {
    if animationName.isEmpty || numberOfFrames == 0 {
        return nil
    }

    var textures = [SKTexture]()
    if let atlas = atlas {
        for idx in 0 ..< numberOfFrames {
            let textureName = "\(animationName)-\(idx)"
            let texture = atlas.textureNamed(textureName)
            textures.append(texture)
        }
    } else {
        for idx in 0 ..< numberOfFrames {
            let textureName = "\(animationName)-\(idx)"
            let texture = SKTexture(imageNamed: textureName)
            textures.append(texture)
        }
    }
    return textures
}

// swiftlint:disable extension_access_modifier
extension SKSpriteNode {
    /// The key used by this category for animation actions
    public static let SSAnimationActionKey = "SSAnimationAction"

    /// Make the sprite node display an animation with a set of textues. If the textures array only contains 1 item, that texture is simply assigned to the sprite, without running an animation action.
    /// - Parameters:
    ///   - textures: The textures to animate with. The array is assumed to only contain SKTexture instances. See the SSKAnimationTexturesFromAtlas function for an easy way to generate these textures.
    ///   - duration: The duration of each cycle of the animation.
    ///   - repeat: Whether the animation should be repeated or not.
    ///   - resize: Whether the sprite node should be resized to fit each texture's size when animating.
    ///   - completion: A completion block to be run when the animation has finished. This parameter is ignored if repeat is set to YES.
    public func animate(with textures: [SKTexture],
                        duration: TimeInterval,
                        repeat: Bool = false,
                        resize: Bool = true,
                        completion: @escaping () -> Void) {
        self.removeAction(forKey: SKSpriteNode.SSAnimationActionKey)

        let count = textures.count
        if count < 2 {
            if let texture = textures.first {
                self.texture = texture
                self.size = texture.size()
            }

            return
        }

        let timePerFrame = duration / TimeInterval(count)
        let action = SKAction.animate(with: textures, timePerFrame: timePerFrame, resize: resize, restore: false)
        if `repeat` {
            self.run(SKAction.repeatForever(action), withKey: SKSpriteNode.SSAnimationActionKey)
        } else {
            self.run(action, completion: completion)
        }
    }
}
