//
//  DartScene.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/01.
//

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

     override func didMove(to view: SKView) {
         backgroundColor = UIColor(.backGroundBeige)

         createDart()
         createDartboard()
     }

     // 다트보드 생성
     func createDartboard() {
         dartboard = SKSpriteNode(imageNamed: "dart_wall")
         dartboard.position = CGPoint(x: screenWidth / 2, y: 702)

         addChild(dartboard)
     }

     // 다트 생성
     func createDart() {
         dart = SKSpriteNode(imageNamed: "jiggy_02")
         dart.position = CGPoint(x: screenWidth / 2, y: 100)

         addChild(dart)
     }

 }
