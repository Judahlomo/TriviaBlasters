//
//  Enemy.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 3/6/25.
//


import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    init(type: EnemyType) {
        let enemyTexture = SKTexture(imageNamed: "Invader\(type.rawValue)")
        super.init(texture: enemyTexture, color: .clear, size: EnemyType.size)

        self.name = EnemyType.name 
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false

        self.physicsBody?.categoryBitMask = kHostileCategory
        self.physicsBody?.contactTestBitMask = 0x0
        self.physicsBody?.collisionBitMask = kFriendlyCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Enemy Spawning & Movement
extension GameEngine {  //

    func setupEnemies() {
        let baseOrigin = CGPoint(x: size.width / 3, y: size.height / 2)

        for row in 0..<kInvaderRowCount {
            var enemyType: EnemyType

            if row < kInvaderRowCount / 3 { enemyType = .A }
            else if row < kInvaderRowCount / 3 * 2 { enemyType = .B }
            else { enemyType = .C }

            let enemyPositionY = CGFloat(row) * (EnemyType.size.height * 2) + baseOrigin.y
            var enemyPosition = CGPoint(x: baseOrigin.x, y: enemyPositionY)

            for _ in 1..<kInvaderColCount {
                let enemy = Enemy(type: enemyType)
                enemy.position = enemyPosition
                addChild(enemy)

                enemyPosition = CGPoint(
                    x: enemyPosition.x + EnemyType.size.width + kInvaderGridSpacing.width,
                    y: enemyPositionY
                )
            }
        }
    }

    // MARK: - Enemy Movement Logic
   /* func moveEnemies(forUpdate currentTime: CFTimeInterval) {
        if (currentTime - timeOfLastMove < timePerMove) { return }
        
        determineEnemyMovementDirection()
      
        enumerateChildNodes(withName: EnemyType.name) { node, stop in
            switch self.enemyMovementDirection { 
            case .right:
                node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
            case .left:
                node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
            case .downThenLeft, .downThenRight:
                node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
            case .none:
                break
            }
        }
        
        timeOfLastMove = currentTime
    }
*/
    func determineEnemyMovementDirection() {
        var proposedMovementDirection: EnemyMovementDirection = enemyMovementDirection
        
        enumerateChildNodes(withName: EnemyType.name) { node, stop in
            switch self.enemyMovementDirection {
            case .right:
                if (node.frame.maxX >= node.scene!.size.width - node.frame.width / 2) {
                    proposedMovementDirection = .downThenLeft
                    stop.pointee = true
                }
            case .left:
                if (node.frame.minX <= node.frame.width / 2) {
                    proposedMovementDirection = .downThenRight
                    stop.pointee = true
                }
            case .downThenLeft:
                proposedMovementDirection = .left
                self.adjustEnemyMovement(to: self.timePerMove * 0.8)
                stop.pointee = true
            case .downThenRight:
                proposedMovementDirection = .right
                self.adjustEnemyMovement(to: self.timePerMove * 0.8)
                stop.pointee = true
            default:
                break
            }
        }
        
        if proposedMovementDirection != enemyMovementDirection {
            enemyMovementDirection = proposedMovementDirection
        }
    }

    func adjustEnemyMovement(to timePerMove: CFTimeInterval) {
        if self.timePerMove <= 0 { return }
        
        let ratio: CGFloat = CGFloat(self.timePerMove / timePerMove)
        self.timePerMove = timePerMove
        
        enumerateChildNodes(withName: EnemyType.name) { node, stop in
            node.speed = node.speed * ratio
        }
    }
}
