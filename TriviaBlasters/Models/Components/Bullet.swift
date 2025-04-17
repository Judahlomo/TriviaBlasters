//
//  Bullet.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 3/6/25.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {

    init(type: BulletType, position: CGPoint) {
        super.init(texture: nil, color: .white, size: kBulletSize) // White bullet with default size

        self.name = (type == .player) ? kShipFiredBulletName : kInvaderFiredBulletName
        self.position = position
        self.zPosition = 1

        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = (type == .player) ? kShipFiredBulletCategory : kInvaderFiredBulletCategory
        self.physicsBody?.contactTestBitMask = (type == .player) ? kHostileCategory : kFriendlyCategory
        self.physicsBody?.collisionBitMask = 0x0

        moveBullet(type: type)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveBullet(type: BulletType) {
        let moveDistance = (type == .player) ? UIScreen.main.bounds.height : -UIScreen.main.bounds.height
        let moveAction = SKAction.moveBy(x: 0, y: moveDistance, duration: (type == .player) ? 1.0 : 2.5)
        let removeAction = SKAction.removeFromParent()
        self.run(SKAction.sequence([moveAction, removeAction]))
    }
}
