//
//  BowlingView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI
import SpriteKit

struct BowlingView: View {
    @Environment(\.dismiss) private var dismiss

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var myscene: SKScene {

        let scene = BowlingGameScene()

        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = UIColor(.backGroundBeige)

        return scene

    }

    var body: some View {
        
        SpriteView(scene: myscene)
            .frame(width: screenWidth, height: screenHeight)
            .edgesIgnoringSafeArea(.all)
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
                    Text("볼링공 던지기")
                        .font(.custom("SFPro-Semibold", size: 17))
                        .tracking(-0.4)
                        .lineSpacing(20)
                }
            }
    }
    
}

struct BowlingView_Previews: PreviewProvider {
    static var previews: some View {
        BowlingView()
    }
}
