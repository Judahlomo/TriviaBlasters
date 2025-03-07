//
//  Enums.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 3/6/25.
//

import SpriteKit

/// Enemy Types
enum EnemyType: String {
    case A = "A"
    case B = "B"
    case C = "C"

    static var size: CGSize {
        return kInvaderSize
    }

    static var name: String {
        return "enemy"
    }
    
    var color: SKColor {
        switch self {
        case .A: return SKColor.red
        case .B: return SKColor.green
        case .C: return SKColor.blue
        }
    }
}

/// Enemy Movement Directions
enum EnemyMovementDirection {
    case right
    case left
    case downThenRight
    case downThenLeft
    case none
}

/// Player Ship Movement Directions
enum ShipMovementDirection: CGFloat {
    case right = 1.0
    case left = -1.0
    case idle = 0.0
}

/// Bullet Types (For both Player and Enemy)
enum BulletType {
    case player, enemy
    
    var bullet: SKNode {
        switch self {
        case .player:
            let bullet = SKSpriteNode(color: SKColor.green, size: kBulletSize)
            bullet.name = kShipFiredBulletName
            return bullet
        case .enemy:
            let bullet = SKSpriteNode(color: SKColor.magenta, size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
            return bullet
        }
    }
}
