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
extension GameEngine {
    
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
    
    func moveEnemies(forUpdate currentTime: CFTimeInterval) {
        if (currentTime - timeOfLastMove < timePerMove) { return }
        
        determineEnemyMovementDirection()
        
        var enemyReachedBottom = false
        let activeEnemyBullets = children.filter { $0.name == kInvaderFiredBulletName }.count
        
        enumerateChildNodes(withName: EnemyType.name) { node, _ in
            switch self.enemyMovementDirection {
            case .right:
                node.position.x += 10
            case .left:
                node.position.x -= 10
            case .downThenLeft, .downThenRight:
                node.position.y -= 10
            case .none:
                break
            }
            
            // Controlled enemy firing
            if currentTime - self.lastEnemyBulletTime > self.enemyBulletCooldown,
               activeEnemyBullets < self.maxEnemyBullets,
               Bool.random() && Int.random(in: 0...5) == 0 {
                if let enemy = node as? Enemy {
                    self.fireEnemyBullet(from: enemy)
                    self.lastEnemyBulletTime = currentTime
                }
            }
            
            if node.position.y <= 50 {
                enemyReachedBottom = true
            }
        }
        
        timeOfLastMove = currentTime
        
        if enemyReachedBottom && !isGameOver {
            pauseGameForTrivia()
        }
    }
    func determineEnemyMovementDirection() {
        var proposedDirection: EnemyMovementDirection = enemyMovementDirection
        
        enumerateChildNodes(withName: EnemyType.name) { node, stop in
            switch self.enemyMovementDirection {
            case .right:
                if node.frame.maxX >= self.size.width - node.frame.width / 2 {
                    proposedDirection = .downThenLeft
                    stop.pointee = true
                }
            case .left:
                if node.frame.minX <= node.frame.width / 2 {
                    proposedDirection = .downThenRight
                    stop.pointee = true
                }
            case .downThenLeft:
                proposedDirection = .left
                self.adjustEnemyMovement(to: self.timePerMove * 0.8)
                stop.pointee = true
            case .downThenRight:
                proposedDirection = .right
                self.adjustEnemyMovement(to: self.timePerMove * 0.8)
                stop.pointee = true
            default:
                break
            }
        }
        
        if proposedDirection != enemyMovementDirection {
            enemyMovementDirection = proposedDirection
        }
    }
    
    func adjustEnemyMovement(to newTimePerMove: CFTimeInterval) {
        let minTimePerMove: CFTimeInterval = 0.3
        if newTimePerMove < minTimePerMove { return }
        
        let ratio: CGFloat = CGFloat(timePerMove / newTimePerMove)
        timePerMove = max(newTimePerMove, minTimePerMove)
        
        enumerateChildNodes(withName: EnemyType.name) { node, _ in
            node.speed *= ratio
        }
    }
    
    func pauseGameForTrivia() {
        self.isPaused = true
        self.shouldSpawnWaveAfterTrivia = true
        NotificationCenter.default.post(name: Notification.Name("TriggerTriviaPopup"), object: nil)
    }
}
