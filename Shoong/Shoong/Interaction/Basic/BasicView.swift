//
//  InterectionView.swift
//  BasicInterection
//
//  Created by Zerom on 2023/07/20.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
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

struct BasicView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
    private let soundManager = SoundManager()
    @State private var xAxis: CGFloat = 0.0
    @State private var yAxis: CGFloat = 400.0
    @State private var width: CGFloat = 0.4
    @State private var height: CGFloat = 0.4
    @State private var opacity: Double = 1.0
    @State private var isMessagePresented = true
    @State private var count: Int = 0
    @State private var isNavi: Bool = false
    
    @Binding var firstNaviLinkActive: Bool
    
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var drag: some Gesture {
        DragGesture()
            .onEnded {_ in
                impactFeedbackGenerator.impactOccurred()
                soundManager.playSound()
                self.width = 0.01
                self.height = 0.01
                self.yAxis = -600
                count += 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.opacity = 0.0
                    self.width = 0.4
                    self.height = 0.4
                    self.yAxis = 400
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.opacity = 1.0
                }
            }
    }
    
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color.fontGray)
                    .opacity(0.1)
                    .frame(width: 357, height: 110)
                
                VStack(alignment: .leading) {
                    Text("사직서를 힘차게 날리는 중이군요!")
                        .font(.custom("SFPro-Bold", size: 13))
                        .foregroundColor(.fontRed)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 330, height: 7)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.fontRed)
                            .frame(width: 163, height: 7)
                    }
                    
                    Text("날린 사직서 갯수")
                        .font(.custom("SFPro-Regular", size: 11))
                        .foregroundColor(.fontGray)
                        .padding(.top, 5)
                        .opacity(0.6)
                    
                    Text("\(count)")
                        .font(.custom("SFPro-Semibold", size: 15))
                        .foregroundColor(.fontGray)
                }
            }
            .offset(y: -280)
            
            Image("sagicser")
                .scaleEffect(CGSize(width: width, height: height))
                .offset(x: xAxis, y: yAxis)
                .animation(.linear(duration: 0.2), value: CGSize(width: width, height: height))
                .animation(.linear(duration: 0.2), value: yAxis)
                .gesture(drag)
                .opacity(opacity)
            
            if isMessagePresented {
                HowToPlay(playImageName: "resignationLetterHowToPlay", isMessagePresented: $isMessagePresented)
            }
            
            NavigationLink(destination: ResultView(firstNaviLinkActive: $firstNaviLinkActive).environmentObject(coreDataViewModel), isActive: $isNavi) {
                Text(".")
                    .opacity(0)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.backward")
                            .fontWeight(.semibold)
                        
                        Text("뒤로")
                    }
                    .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("사직서 날리기")
                    .bold()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isNavi.toggle()
                } label: {
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
            }
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        BasicView(firstNaviLinkActive: .constant(true))
    }
}
