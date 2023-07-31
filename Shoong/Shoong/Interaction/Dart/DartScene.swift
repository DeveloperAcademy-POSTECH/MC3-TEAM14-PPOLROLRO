//
//  DartScene.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/01.
//

import GameplayKit
import CoreMotion
import AVFoundation
import SpriteKit
import SwiftUI

// SKPhysicsContactDelegate : 충돌 감지에 필요한 프로토콜
final class DartScene: SKScene, SKPhysicsContactDelegate {
    
    // 화면 관련 변수
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // 화면 경계 관련 변수
    var topBorder: SKShapeNode!
    var leftBorder: SKShapeNode!
    var rightBorder: SKShapeNode!
    var bottomBorder: SKShapeNode!

    // 노드 관련 변수
    var darts: [SKSpriteNode] = []
    var dart : SKSpriteNode!
    var dartboard: SKSpriteNode!
    
    // 게임 진행 관련 변수
    var isDartThrown = false
    
    // 가속도 관련 변수
    private var motionManager = CMMotionManager()
    private var previousAcceleration: CMAcceleration?
    
    // 소리 관련 변수
    var player: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(.backGroundBeige)
        
        setUpPhysicsWorld()
        createDart()
        createDartboard()
        createBorder()
        startDarting()
    }
    
    // 물리 세계 설정 : 중력 0
    func setUpPhysicsWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    // 다트보드 생성
    func createDartboard() {
        dartboard = SKSpriteNode(imageNamed: "dart_wall")
        dartboard.position = CGPoint(x: screenWidth / 2, y: 702)
        dartboard.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dartboard.size.width, height: dartboard.size.height))
        dartboard.physicsBody?.isDynamic = false
        dartboard.physicsBody?.categoryBitMask = PhysicsCategory.dartboard

        addChild(dartboard)
    }
    
    // 화면 border 생성
    func createBorder() {
        topBorder = SKShapeNode(rectOf: CGSize(width: screenWidth, height: 1))
        
        topBorder.position = .init(x: screenWidth / 2, y: screenHeight - 100)
        topBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 1))
        topBorder.physicsBody?.isDynamic = false
        topBorder.physicsBody?.categoryBitMask = PhysicsCategory.border
        topBorder.physicsBody?.contactTestBitMask = PhysicsCategory.dart
        topBorder.strokeColor = .clear

        addChild(topBorder)
        
        leftBorder = SKShapeNode(rectOf: CGSize(width: 1, height: screenHeight))
        
        leftBorder.position = .init(x: 10, y: screenHeight / 2)
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: screenHeight))
        leftBorder.physicsBody?.isDynamic = false
        leftBorder.physicsBody?.categoryBitMask = PhysicsCategory.border
        leftBorder.physicsBody?.contactTestBitMask = PhysicsCategory.dart
        leftBorder.strokeColor = .clear

        addChild(leftBorder)
        
        rightBorder = SKShapeNode(rectOf: CGSize(width: 1, height: screenHeight))
        
        rightBorder.position = .init(x: screenWidth - 10, y: screenHeight / 2)
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: screenHeight))
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.physicsBody?.categoryBitMask = PhysicsCategory.border
        rightBorder.physicsBody?.contactTestBitMask = PhysicsCategory.dart
        rightBorder.strokeColor = .clear

        addChild(rightBorder)
        
        bottomBorder = SKShapeNode(rectOf: CGSize(width: screenWidth, height: 1))
        
        bottomBorder.position = .init(x: screenWidth / 2, y: 20)
        bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 1))
        bottomBorder.physicsBody?.isDynamic = false
        bottomBorder.physicsBody?.categoryBitMask = PhysicsCategory.border
        bottomBorder.physicsBody?.contactTestBitMask = PhysicsCategory.dart
        bottomBorder.strokeColor = .clear
        
        addChild(bottomBorder)
    }
    
    // 다트 생성
    func createDart() {
        dart = SKSpriteNode(imageNamed: "jiggy_02")
        
        dart.physicsBody?.affectedByGravity = false
        dart.position = CGPoint(x: screenWidth / 2, y: 100)
        dart.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dart.size.width, height: dart.size.height))
        dart.physicsBody?.categoryBitMask = PhysicsCategory.dart
        dart.physicsBody?.contactTestBitMask = PhysicsCategory.dartboard
        dart.physicsBody?.collisionBitMask = PhysicsCategory.dartboard

        // 다트 배열에 넣은 뒤 마지막 값을 움직이게 만듬
        darts.append(dart)
        addChild(darts.last!)
    }

    
    // 다트 게임 시작
    private func startDarting() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let acceleration = data?.acceleration else { return }
                
                if let accelerationChange = self?.calculateAccelerationChange(currentAcceleration: acceleration) {
                    
                    if accelerationChange > 1.2 {
                        self?.startMotionManager(acceleration: acceleration)
                    }
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var collideBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            collideBody = contact.bodyB
        } else {
            collideBody = contact.bodyA
        }
        
        // 다트가 다트판에 꽂혔을 시 실행할 행동
        if collideBody.categoryBitMask == PhysicsCategory.dartboard {
            print("target!")
            darts.last?.physicsBody?.linearDamping = 1
            darts.last?.physicsBody?.isDynamic = false
            playSound()
        }
        
        // 충돌 시 새 다트 생성
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.darts.last?.physicsBody?.linearDamping = 0
            self.isDartThrown = true
            
            if self.isDartThrown {
                self.isDartThrown = false
                self.createDart()
            }
        }
        
        // 다트가 화면 밖으로 나갔을 때
        if collideBody.categoryBitMask == PhysicsCategory.border {
            print("border!")
            darts.popLast()?.removeFromParent()
        }
    }
    
    // 핸드폰 움직임의 가속도를 받아오는 함수
    private func calculateAccelerationChange(currentAcceleration: CMAcceleration) -> Double? {
        guard let previousAcceleration = previousAcceleration else {
            self.previousAcceleration = currentAcceleration
            return nil
        }
        
        let deltaZ = currentAcceleration.z - previousAcceleration.z
        let accelerationChange = sqrt(deltaZ * deltaZ)
        
        self.previousAcceleration = currentAcceleration
        
        return accelerationChange
    }
    
    // 움직임 감지 시 가속도 추가
    private func startMotionManager(acceleration: CMAcceleration) {
        guard motionManager.isAccelerometerAvailable else {
            return
        }
        darts.last?.physicsBody?.isDynamic = true
        darts.last?.physicsBody?.applyImpulse(CGVector(dx: CGFloat(acceleration.y) * 30, dy: 100))
    }
    
    // 사운드 플레이 함수
    func playSound() {
        let url = Bundle.main.url(forResource: "dartSound", withExtension: "m4a")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
