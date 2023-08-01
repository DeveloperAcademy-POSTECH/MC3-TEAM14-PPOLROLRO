//
//  HapticManager.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/01.
//

import CoreHaptics
import Foundation

class HapticManager {
    
    let hapticEngine: CHHapticEngine
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        guard hapticCapability.supportsHaptics else {
            return nil
        }
        
        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            print("Haptic engine Creation Error: \(error)")
            return nil
        }
    }
    
    func playHaptic() {
        do {
            let pattern = try hapticPattern()
            
            try hapticEngine.start()
            
            let player = try hapticEngine.makePlayer(with: pattern)
            
            try player.start(atTime: CHHapticTimeImmediate)
            
            hapticEngine.notifyWhenPlayersFinished { _ in
                return .stopEngine
            }
        } catch {
            print("Failed to play haptic: \(error)")
        }
    }
}

extension HapticManager {
    private func hapticPattern() throws -> CHHapticPattern {
        let fly = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ],
            relativeTime: 0,
            duration: 0.5)
        
        let hit = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ],
            relativeTime: 0.05)
        
        return try CHHapticPattern(events: [fly, hit], parameters: [])
    }
}
