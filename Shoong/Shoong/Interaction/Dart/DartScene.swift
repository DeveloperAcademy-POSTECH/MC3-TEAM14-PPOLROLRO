//
//  DartScene.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/01.
//

import CoreMotion
import SpriteKit
import SwiftUI

// SKPhysicsContactDelegate : 충돌 감지에 필요한 프로토콜
final class DartScene: SKScene, SKPhysicsContactDelegate {
    
     // 화면 관련 변수
     let screenWidth = UIScreen.main.bounds.width
     let screenHeight = UIScreen.main.bounds.height
     
     // 노드 관련 변수
     var dart : SKSpriteNode!
     var dartboard: SKSpriteNode!

     // 가속도 관련 변수
     private var motionManager = CMMotionManager()
     private var previousAcceleration: CMAcceleration?

     override func didMove(to view: SKView) {
         backgroundColor = UIColor(.backGroundBeige)

         setUpPhysicsWorld()
         createDart()
         createDartboard()
         startDarting()
     }

     // 물리 세계 설정 : 중력 0
     func setUpPhysicsWorld() {
         self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
     }

     // 다트보드 생성
     func createDartboard() {
         dartboard = SKSpriteNode(imageNamed: "dart_wall")
         dartboard.position = CGPoint(x: screenWidth / 2, y: 702)

         dartboard.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dartboard.size.width, height: dartboard.size.height))
         dartboard.physicsBody?.isDynamic = false

         addChild(dartboard)
     }

     // 다트 생성
     func createDart() {
         dart = SKSpriteNode(imageNamed: "jiggy_02")
         dart.position = CGPoint(x: screenWidth / 2, y: 100)

         dart.physicsBody?.affectedByGravity = false
         dart.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dart.size.width, height: dart.size.height))

         addChild(dart)
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
         dart.physicsBody?.isDynamic = true
         dart.physicsBody?.applyImpulse(CGVector(dx: CGFloat(acceleration.y) * 30, dy: 100))
     }
 }
