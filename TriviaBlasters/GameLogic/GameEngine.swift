//
//  GameEngine.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 3/6/25.
//

import Foundation
import SpriteKit

class GameEngine: SKScene, ObservableObject {
    @Published var score: Int = 0
    @Published var lives: Int = 3
    @Published var isGameOver = false

    var player: PlayerShip!
    var enemies: [Enemy] = []
    var bullets: [Bullet] = []
    
    var timeOfLastMove: CFTimeInterval = 0  // Tracks last move time
    var timePerMove: CFTimeInterval = 1.0   // Adjust for difficulty
    var enemyMovementDirection: EnemyMovementDirection = .right  // Initial movement direction


    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // Add player to scene
        player = PlayerShip()
        player.position = CGPoint(x: size.width / 2, y: 100)
        addChild(player)
        
        // Spawn enemies
        spawnEnemies()
    }

    override func update(_ currentTime: TimeInterval) {
        moveEnemies(forUpdate: currentTime)
        moveBullets()
        checkBulletCollisions()
    }

    func movePlayer(_ direction: CGFloat) {
        let newX = player.position.x + direction
        if newX > 30 && newX < size.width - 30 {
            player.position.x = newX
        }
    }

    func fireBullet() {
            let bullet = Bullet(type: .player, position: CGPoint(x: player.position.x, y: player.position.y + 20))
            addChild(bullet)
        }
    
    func fireEnemyBullet(from enemy: Enemy) {
            let bullet = Bullet(type: .enemy, position: CGPoint(x: enemy.position.x, y: enemy.position.y - 20))
            addChild(bullet)
        }

    func moveBullets() {
            enumerateChildNodes(withName: kShipFiredBulletName) { bullet, _ in
                if bullet.position.y > self.size.height {
                    bullet.removeFromParent()
                }
            }

            enumerateChildNodes(withName: kInvaderFiredBulletName) { bullet, _ in
                if bullet.position.y < 0 {
                    bullet.removeFromParent()
                }
            }
        }

    func moveEnemies(forUpdate currentTime: CFTimeInterval) {
        if (currentTime - timeOfLastMove < timePerMove) { return }
        
        determineEnemyMovementDirection()

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
        }

        timeOfLastMove = currentTime
    }


    func checkBulletCollisions() {
            enumerateChildNodes(withName: kShipFiredBulletName) { bullet, _ in
                self.enumerateChildNodes(withName: "enemy") { enemy, _ in
                    if bullet.frame.intersects(enemy.frame) {
                        self.score += 100
                        bullet.removeFromParent()
                        enemy.removeFromParent()
                    }
                }
            }

            enumerateChildNodes(withName: kInvaderFiredBulletName) { bullet, _ in
                if bullet.frame.intersects(self.player.frame) {
                    self.lives -= 1
                    bullet.removeFromParent()
                    if self.lives <= 0 {
                        self.isGameOver = true
                    }
                }
            }
        }


    func spawnEnemies() {
        for _ in 1...5 {
            let enemyType: EnemyType = [.A, .B, .C].randomElement()!
            let enemy = Enemy(type: enemyType)
            enemy.position = CGPoint(x: CGFloat.random(in: 50...(size.width - 50)), y: size.height - 50)
            addChild(enemy)
            enemies.append(enemy)
        }
    }
}

    
