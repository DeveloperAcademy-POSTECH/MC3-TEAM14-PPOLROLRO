//
//  InterectionView.swift
//  BasicInterection
//
//  Created by Zerom on 2023/07/20.
//

import SwiftUI
import AVKit

class BasicInteractionSoundManager {
    static let instance = BasicInteractionSoundManager()
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "basicInteractionSound", withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct BasicInteractionView: View {
    private let soundManager = BasicInteractionSoundManager()
    @State private var xAxis: CGFloat = 0.0
    @State private var yAxis: CGFloat = 400.0
    @State private var width: CGFloat = 1.0
    @State private var height: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var drag: some Gesture {
        DragGesture()
            .onEnded {_ in
                impactFeedbackGenerator.impactOccurred()
                soundManager.playSound()
                self.width = 0.01
                self.height = 0.01
                self.yAxis = -600
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.opacity = 0.0
                    self.width = 1.0
                    self.height = 1.0
                    self.yAxis = 400
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.opacity = 1.0
                }
            }
    }
    
    var body: some View {
        ZStack {
            Image("sagicser")
                .scaleEffect(CGSize(width: width, height: height))
                .offset(x: xAxis, y: yAxis)
                .animation(.linear(duration: 0.2), value: CGSize(width: width, height: height))
                .animation(.linear(duration: 0.2), value: yAxis)
                .gesture(drag)
                .opacity(opacity)
        }
    }
}

struct InterectionView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInteractionView()
    }
}
