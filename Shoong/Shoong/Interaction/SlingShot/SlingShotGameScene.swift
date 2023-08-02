//
//  SlingShotView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI
import UIKit
import SpriteKit

struct SlingShotGameScene: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isMessagePresented = true

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //네
    var myscene: SKScene {

        let scene = SlingShotViewModel() //GameScene.swift의 class

        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = UIColor(.backGroundBeige)

        return scene

    }

    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: myscene)
                .edgesIgnoringSafeArea(.all)
            ZStack{
                HStack(alignment: .bottom) {
                    ThrownCount(count: 0)
                    Spacer()
                    GuageBar()
                }
                .padding(.leading, 19)
                .padding(.trailing, 16)
                .padding(.bottom, 24)
            }
            if isMessagePresented {
                HowToPlay(playImageName: "slingshotHowToPlay", isMessagePresented: $isMessagePresented)
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
                            .font(.custom("SFPro-Semibold", size: 17))
                        Text("뒤로")
                            .font(.custom("SFPro-Regular", size: 17))
                    }
                    .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("새총 쏘기")
                    .font(.custom("SFPro-Semibold", size: 17))
                    .tracking(-0.4)
                    .lineSpacing(20)
                    .foregroundColor(.black)
            }
        }
    }
}

struct SlingShotGameScene_Previews: PreviewProvider {
    static var previews: some View {
        SlingShotGameScene()
    }
}
