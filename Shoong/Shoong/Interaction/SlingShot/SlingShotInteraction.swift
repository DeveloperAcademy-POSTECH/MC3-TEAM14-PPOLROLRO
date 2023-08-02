//
//  SlingShotInteraction.swift
//  Shoong
//
//  Created by Sup on 2023/08/01.
//

import Foundation
import SpriteKit
import UIKit

class SlingShotViewModel: SKScene, SKPhysicsContactDelegate {

    var line: SKShapeNode?
    var touchArea: SKSpriteNode?
    var isDragging = false
    var dragY: CGFloat = 0
    var dragX: CGFloat = 0

    let ball = SKSpriteNode(imageNamed: "angry_jiggy")

    // 점수를 위한 전역변수
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
    var score = 0

    // Haptic feedback generators
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

    //sound Option
    let sound = SKAction.playSoundFileNamed("SlingShotBrokenSound.mp3", waitForCompletion: false)


    // object별 physic category설정
    struct PhysicsCategory{
        static let Ball: UInt32 = 1
        static let Line: UInt32 = 2
        static let Company: UInt32 = 4

    }


// 선택할 물체(node)를 위한 변수 , 모든 터치에서 접근 가능해야하므로 전역변수
    var selectedNode: SKNode?
    // 맨처음 발사체가 화면에 나타나는 위치
    let slingShotPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 ) // 기준점 설정

    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self // 충돌기능을 작동시켜줄 delegate

//        scoring()
        makeLine()
        addLineTouchArea()

        makingBall() // 움직일 물체 생성

        // 회사 3개 생성
        createCompany(pos: CGPoint(
            x: Int.random(in: 30...150),
            y: Int.random(in: Int(UIScreen.main.bounds.midY + 70)...Int(UIScreen.main.bounds.maxY - 125))
        )
        )
        createCompany(pos: CGPoint(
            x: Int.random(in: 30...150),
            y: Int.random(in: Int(UIScreen.main.bounds.midY + 55)...Int(UIScreen.main.bounds.maxY - 100))
        )
        )

        createCompany(pos: CGPoint(
            x: Int.random(in: 30...150),
            y: Int.random(in: Int(UIScreen.main.bounds.midY + 40)...Int(UIScreen.main.bounds.maxY - 80))
        )
        )

    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {



        let touch = touches.first! // touches는 모든 터치를 가지고 있어서 맨처음 터치를 기록
        let location = touch.location(in: self) // 맨처음 터치의 location기록

        // nodes()는 SKNode클래스의 method / 위치,크기,회전등 기본적인 속성가짐
        // nodes()가 하는 역할은 주어진 점에 위치한 모든 노드를 배열로 반환
        let touchedNodes = nodes(at: location) // location에 위치한 모든 node반환
        // 모든 노드에서 우리가 움직이려고 한 object만 찾아내기
        // (이러면 같은 위치에 다양한 노드가 겹칠때 원하는 것만 골라내기 가능)
        for node in touchedNodes {
            if node.name == "ball" {
                selectedNode = node // 움직이길 원하는 node를 selectNode에 넣기
            }
        }

        if touchArea?.contains(location) == true {
            isDragging = true
            dragX = location.x
            dragY = location.y
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedNode = selectedNode else { return } // selectedNode가 없으면 실행안됨
        let touch = touches.first! // touches는 모든 터치를 가지고 있어서 맨처음 터치를 기록
        let location = touch.location(in: self) // 맨처음 터치의 location기록
        // selectedNode에 위치값넣어주기
        // 이렇게 되면 seletecNode 즉,선택된 노드가 있을 경우에만 location을 넣기 되고 움직이기 시작한다.
        selectedNode.position = location

        if isDragging {
            let touch = touches.first!
            let location = touch.location(in: self)

            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: frame.midY / 2))
            path.addCurve(to: CGPoint(x: frame.maxX, y: frame.midY / 2), controlPoint1: CGPoint(x: dragX, y: dragY), controlPoint2: CGPoint(x: location.x, y: location.y))
            print("dragX:\(dragX) , locationX:\(location.x)")
            line?.path = path.cgPath
            touchArea?.position.y = location.x
            touchArea?.position.y = location.y
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // selectedNode 없으면 실행안됨
        guard let selectedNode = selectedNode else { return }
        let touch = touches.first! //위의 함수와 동일
        let location = touch.location(in: self) //위의 함수와 동일

        // 발사체가 처음에 존재한 위치(slingShotPosition) - 터치가 끝나는 시점의 위치 (location)
        // 차이 구해주기
        let dx = slingShotPosition.x - location.x
        let dy = slingShotPosition.y - location.y

        //CGVection로 node에 적용할 충격의 방향과 크기 결정
        let impulse = CGVector(dx: dx, dy: dy)
        //selectedNode에 충격적용코드
        selectedNode.physicsBody?.applyImpulse(impulse)

        isDragging = false

        // Reset the line to its original position
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.midY / 2))
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.midY / 2))
        line?.path = path.cgPath


        // 아래처럼 seletecNode를 해제해주지 않으면
        // 빈공간에서 터치로 움직이면 obejct가 터치 위치로 딸려온다
        self.selectedNode = nil

    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        touchesCancelled은 시스템이 터치 이벤트를 취소할 때 호출. 주로 시스템 레벨에서 발생
//        ex. 전화, 알림
//        하는 역할은 touchesEnded은 동일하나 시스템 이벤트가 일어날때 취소하는 것을 가정하려면 여기에 넣어줘야한다.
        self.selectedNode = nil
    }

    override func update(_ currentTime: TimeInterval) {

        if !frame.contains(ball.position) {


            // 1초 후에 새 물체를 생성합니다.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.ball.removeFromParent()
                self.makingBall()
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {

        let collisionObject = contact.bodyA.categoryBitMask == PhysicsCategory.Company ? contact.bodyB : contact.bodyA


        // bullet이 alien맞으면 총알과 bullet이 사라지는 것
        if collisionObject.categoryBitMask == PhysicsCategory.Ball {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()

            // Haptic feedback Trigger
            impactFeedbackGenerator.impactOccurred()

            //충돌 시 불꽃 효과 추가
            let fireParticle = SKEmitterNode(fileNamed: "FireParticle")
            fireParticle?.position = contact.contactPoint //충돌 지점에서 효과 발생
            self.addChild(fireParticle!)

            // 파티클이 일정 시간 후 사라지도록 설정
            let wait = SKAction.wait(forDuration: 0.4)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            fireParticle?.run(sequence)

            //충돌 시 사운드 효과 추가
            self.run(sound)

            //ball에 맞아 회사가 사라질 떄마다 새로 만들어주기
            createCompany(pos: CGPoint(
                x: Int.random(in: 30...180),
                y: Int.random(in: Int(UIScreen.main.bounds.midY + 70)...Int(UIScreen.main.bounds.maxY - 125)))
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.ball.removeFromParent()
                self.makingBall()
            }

            // score 더해주기
            score += 1
            scoreLabel.text = "\(score)번 퇴사 성공"

        }
    }

    // 움직일 물체
    func makingBall(){

        ball.size = CGSize(width: 50, height: 50)
        ball.name = "ball"
        ball.position = slingShotPosition
        ball.position = CGPoint(x: frame.midX + 20 , y: frame.midY / 2 + 20 )
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false

        // For the object
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = 0

        addChild(ball)

    }

    func makeLine(){

        let basicPath = UIBezierPath()
        basicPath.move(to: CGPoint(x: 0, y: frame.midY / 2))
        basicPath.addLine(to: CGPoint(x: frame.maxX  , y: frame.midY / 2))

        line = SKShapeNode(path: basicPath.cgPath)
        line?.strokeColor = .black
        line?.lineWidth = 1

        line?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.maxX, height: 2), center: CGPoint(x: frame.maxX / 2, y: frame.midY / 2))

        line?.physicsBody?.affectedByGravity = false
        line?.physicsBody?.isDynamic = false
        line?.physicsBody?.usesPreciseCollisionDetection = false

        // For the line
        line?.physicsBody?.categoryBitMask = PhysicsCategory.Line
        line?.physicsBody?.collisionBitMask = 0

        addChild(line!)

    }

    func addLineTouchArea(){
        touchArea = SKSpriteNode(color: .clear, size: CGSize(width: frame.width, height: frame.height))
        touchArea?.position = CGPoint(x: frame.midX, y: frame.midY / 2)
        addChild(touchArea!)

    }


    // ---------- Mark : 맞출 회사 만들기  ----------------
    func createCompany(pos: CGPoint){

        // -- Basic properties setup
        let randomSize = CGFloat.random(in: 1...2)
        let company = SKSpriteNode(imageNamed: "black_building_01")

        company.size = CGSize(width: company.size.width * randomSize, height: company.size.height * randomSize)
        company.position = pos
        company.name = "company"

        // -- Physics properties setup

        company.physicsBody = SKPhysicsBody(rectangleOf: company.frame.size)
        company.physicsBody?.isDynamic = false
        company.physicsBody!.affectedByGravity = false // 화면 상단 x축에서 움직여야해서 중력 off
        company.physicsBody!.usesPreciseCollisionDetection = true //맞으면 사라져야해서 on

        // 충돌시 사라짐을 위한 설정
        company.physicsBody!.categoryBitMask = PhysicsCategory.Company
        company.physicsBody!.contactTestBitMask = PhysicsCategory.Ball


        //Scene에 추가
        self.addChild(company)

        //company의 움직임 추가하기
        let moveRight = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 0.55)
        let moveLeft = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 0.55)

        let sequence = SKAction.sequence([moveRight,moveLeft])
        let reqeatSequence = SKAction.repeatForever(sequence)

        company.run(reqeatSequence)
    }

    func scoring(){

        scoreLabel.text = "\(score)번 퇴사 성공"
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 100)
        scoreLabel.fontColor = .blue

        addChild(scoreLabel)

    }
}

