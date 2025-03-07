//
//  PlayerShip.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 3/6/25.
//

import Foundation
import SpriteKit

class PlayerShip: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "PlayerShip") 
        super.init(texture: texture, color: .clear, size: CGSize(width: 39, height: 20.8))

        self.name = "PlayerShip"
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 0.02

        self.physicsBody?.categoryBitMask = kFriendlyCategory
        self.physicsBody?.contactTestBitMask = 0x0
        self.physicsBody?.collisionBitMask = kSceneEdgeCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Positions the ship at the bottom of the screen
    func setupShip(in scene: SKScene) {
        let bottomInset = scene.view?.safeAreaInsets.bottom ?? CGFloat(34)
        self.position = CGPoint(x: scene.size.width / 2.0, y: self.size.height / 2.0 + bottomInset)
        scene.addChild(self)
    }
    
    /// Moves the ship based on user input
    func move(direction: ShipMovementDirection, screenWidth: CGFloat) {
        let newX = position.x + (direction.rawValue * 15) // 15 is the movement speed
        if newX > size.width / 2 && newX < screenWidth - size.width / 2 {
            position.x = newX
        }
    }
}
