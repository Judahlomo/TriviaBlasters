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
    @Published var isTriviaTime: Bool = false
    
    var player: PlayerShip!
    var enemies: [Enemy] = []
    var bullets: [Bullet] = []
    
    var timeOfLastMove: CFTimeInterval = 0
    var timePerMove: CFTimeInterval = 0.2
    var enemyMovementDirection: EnemyMovementDirection = .right
    
    var maxActiveBullets = 5
    var bulletCooldown: TimeInterval = 0.2
    var lastBulletFiredAt: TimeInterval = 0
    
    var lastEnemyBulletTime: TimeInterval = 0
    let enemyBulletCooldown: TimeInterval = 1.5
    let maxEnemyBullets: Int = 5
    
    var shouldSpawnWaveAfterTrivia = false

    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // Add player
        player = PlayerShip()
        player.position = CGPoint(x: size.width / 2, y: 100)
        addChild(player)
        
        // Spawn enemies
        spawnEnemies()
        
        // Listen for trivia notification
        NotificationCenter.default.addObserver(forName: Notification.Name("TriggerTriviaPopup"), object: nil, queue: .main) { _ in
            self.isTriviaTime = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveEnemies(forUpdate: currentTime)
        moveBullets()
        checkBulletCollisions()
        
        // When trivia ends, respawn enemies if needed
           if shouldSpawnWaveAfterTrivia && !isPaused && !isTriviaTime && !isGameOver {
               let remainingEnemies = children.filter { $0.name == EnemyType.name }
               if remainingEnemies.isEmpty {
                   setupEnemies()
                   shouldSpawnWaveAfterTrivia = false
               }
           }
       }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func movePlayer(_ direction: CGFloat) {
        let newX = player.position.x + direction
        if newX > 30 && newX < size.width - 30 {
            player.position.x = newX
        }
    }
    
    func fireBullet() {
        // Count current active bullets
        let activeBullets = children.filter { $0.name == kShipFiredBulletName }.count

        // Enforce cooldown and bullet cap
        if activeBullets < maxActiveBullets && CACurrentMediaTime() - lastBulletFiredAt >= bulletCooldown {
            let bullet = Bullet(type: .player, position: CGPoint(x: player.position.x, y: player.position.y + 20))
            addChild(bullet)
            lastBulletFiredAt = CACurrentMediaTime()
        }
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
        let baseOrigin = CGPoint(x: size.width / 3, y: size.height / 2)

        for row in 0..<kInvaderRowCount {
            var enemyType: EnemyType

            if row < kInvaderRowCount / 3 { enemyType = .A }
            else if row < kInvaderRowCount / 3 * 2 { enemyType = .B }
            else { enemyType = .C }

            let enemyY = CGFloat(row) * (EnemyType.size.height * 2) + baseOrigin.y
            var enemyX = baseOrigin.x

            for _ in 1..<kInvaderColCount {
                let enemy = Enemy(type: enemyType)
                enemy.position = CGPoint(x: enemyX, y: enemyY)
                addChild(enemy)
                enemies.append(enemy)

                enemyX += EnemyType.size.width + kInvaderGridSpacing.width
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let leftZone = size.width * 0.3
        let rightZone = size.width * 0.7
        
        if location.x < leftZone {
            movePlayer(-20)
        } else if location.x > rightZone {
            movePlayer(20)
        } else {
            fireBullet()
        }
    }
}
