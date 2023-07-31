//
//  GameScene.swift
//  CoreMotionTestBowling
//
//  Created by Zerom on 2023/07/11.
//

import SpriteKit
import GameplayKit
import CoreMotion
import CoreHaptics
import AVFoundation

class BowlingGameScene: SKScene, SKPhysicsContactDelegate {
    // 노드 관련 변수
    private var ballNode: SKSpriteNode!
    private var pins: [SKSpriteNode] = []
    let aspectRatio = SKTexture(imageNamed: "pin.png").size().width / SKTexture(imageNamed: "pin.png").size().height
    private var leftBorder: SKSpriteNode!
    private var rightBorder: SKSpriteNode!
    
    // 전체 게임 관련 변수
    private var isGameOver = false
    
    // 가속도 관련 변수
    private var motionManager = CMMotionManager()
    private var timer: Timer!
    private var previousAcceleration: CMAcceleration?
    private var previousGyro: CMGyroData?
    private var isTumbled = false
    
    private var accelerationData: CMAcceleration?
    private var gyroData: CMGyroData?
    
    // 햅틱 관련 변수
    private var engine: CHHapticEngine?
    private var hapticFeedback = UIImpactFeedbackGenerator(style: .rigid)
    private var hapticNotification = UINotificationFeedbackGenerator()
    
    // 효과음 관련 변수
    private var collisionSoundPlayer: AVAudioPlayer?
    
    // MARK: - 게임 관련 메서드
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        createPlayer()
        startBallTumble()
        loadCollisionSound()
    }
    
    private func endingGame() {
        // self.ballNode.physicsBody?.isDynamic = false
        isGameOver = true
        isTumbled = false
    }
    
    private func restartGame() {
        removeAllChildren()
        self.pins = []
        createPlayer()
        startBallTumble()
        isGameOver = false
    }
    
    private func createPlayer() {
        ballNode = SKSpriteNode(imageNamed: "ball")
        ballNode.position = CGPoint(x: 0, y: -frame.height / 3 - 100)
        ballNode.size = CGSize(width: 80, height: 80)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNode.size.width / 2)
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.affectedByGravity = false
        ballNode.physicsBody?.density = 4.0
        ballNode.physicsBody?.categoryBitMask = 1
        ballNode.physicsBody?.contactTestBitMask = 2
        // ballNode.zPosition = 1
        addChild(ballNode)
        
        // 영역 왼쪽 설정
        leftBorder = SKSpriteNode()
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: UIScreen.main.bounds.height))
        leftBorder.physicsBody?.affectedByGravity = false
        leftBorder.physicsBody?.isDynamic = false
        leftBorder.position = .init(x: UIScreen.main.bounds.width / 2 + 100, y: 0)
        addChild(leftBorder)

        // 영역 오른쪽 설정
        rightBorder = SKSpriteNode()
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: UIScreen.main.bounds.height))
        rightBorder.physicsBody?.affectedByGravity = false
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.position = .init(x: -UIScreen.main.bounds.width / 2 - 100, y: 0)
        addChild(rightBorder)
        
        let pinPositions: [CGPoint] = [
            .init(x: 0, y: frame.height / 4),
            .init(x: -60, y: frame.height / 4 + 70),
            .init(x: 60, y: frame.height / 4 + 70),
            .init(x: 0, y: frame.height / 4 + 140),
            .init(x: 120, y: frame.height / 4 + 140),
            .init(x: -120, y: frame.height / 4 + 140),
            .init(x: -60, y: frame.height / 4 + 210),
            .init(x: 60, y: frame.height / 4 + 210),
            .init(x: -180, y: frame.height / 4 + 210),
            .init(x: 180, y: frame.height / 4 + 210)
        ]
        
        for position in pinPositions {
            let pin = createPin(position: position)
            pins.append(pin)
            addChild(pin)
        }
    }
    
    private func createPin(position: CGPoint) -> SKSpriteNode {
        let pin = SKSpriteNode(imageNamed: "pin")
        pin.size = CGSize(width: 60 * aspectRatio, height: 60)
        pin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50 * aspectRatio, height: 50))
        pin.physicsBody?.affectedByGravity = false
        pin.physicsBody?.isDynamic = true
        pin.physicsBody?.density = 2.0
        pin.position = position
        pin.physicsBody?.categoryBitMask = 2
        return pin
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
    }
    
    // MARK: - 가속도 관련 메서드
    private func calculateAccelerationChange(currentAcceleration: CMAcceleration) -> Double? {
        guard let previousAcceleration = previousAcceleration else {
            self.previousAcceleration = currentAcceleration
            return nil
        }
        
        let deltaZ = currentAcceleration.z - previousAcceleration.z
        self.previousAcceleration = currentAcceleration
        return deltaZ
    }
    
    private func startBallTumble() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let acceleration = data?.acceleration else { return }
                self?.accelerationData = acceleration
                
                if let accelerationChange = self?.calculateAccelerationChange(currentAcceleration: acceleration),
                   let gyroChange = self?.gyroData {
                    if accelerationChange > 2.0 && !(self?.isTumbled ?? false) {
                        self?.isTumbled = true
                        self?.startMotionManager(accelerationChange: accelerationChange, gyroData: gyroChange)
                    }
                }
            }
        }
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let gyro = data else { return }
                self?.gyroData = gyro
            }
        }
    }
    
    private func startMotionManager(accelerationChange: Double, gyroData: CMGyroData) {
        guard motionManager.isAccelerometerAvailable else {
            return
        }
        motionManager.stopAccelerometerUpdates()
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.applyImpulse(CGVector(dx: gyroData.rotationRate.z * 80, dy: 50 * accelerationChange * accelerationChange))
    }
    
    // MARK: - 충돌 관련 메서드
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == 1 | 2 {
            self.playHapticFeedback()
            self.playCollisionSound()
            self.endingGame()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.restartGame()
            }
        }
    }
    
    private func ballActionSequence(to position: CGPoint) -> SKAction {
        let move = SKAction.move(to: position, duration: 0.2)
        let scale = SKAction.scale(to: 0.0001, duration: 0.24)
        let remove = SKAction.removeFromParent()
        return SKAction.sequence([move, scale, remove])
    }
    
    // MARK: - 햅틱 관련 메서드
    private func playHapticFeedback() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error starting the haptic engine: \(error)")
        }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Error playing haptic feedback: \(error)")
        }
    }
    
    // MARK: - 소리 관련 메서드
    private func loadCollisionSound() {
        guard let soundURL = Bundle.main.url(forResource: "pinSound", withExtension: "mp3") else {
            print("Failed to find collision sound file.")
            return
        }
        
        do {
            collisionSoundPlayer = try AVAudioPlayer(contentsOf: soundURL)
            collisionSoundPlayer?.prepareToPlay()
        } catch {
            print("Failed to load collision sound file: \(error)")
        }
    }
    
    private func playCollisionSound() {
        collisionSoundPlayer?.play()
    }
}
