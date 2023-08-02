//
//  DartView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI
import SpriteKit

struct DartView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isMessagePresented = true
    @StateObject private var dartScene = DartScene()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteKitContainer(scene: dartScene)
                .ignoresSafeArea()
            ZStack{
                HStack(alignment: .bottom) {
                    ThrownCount(count: dartScene.throwingCount)
                    Spacer()
                    GuageBar()
                }
                .padding(.leading, 19)
                .padding(.trailing, 16)
                .padding(.bottom, 24)
            }
            if isMessagePresented {
                HowToPlay(playImageName: "dartHowToPlay", isMessagePresented: $isMessagePresented)
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
        }
    }
}

struct DartView_Previews: PreviewProvider {
    static var previews: some View {
        DartView()
    }
}
