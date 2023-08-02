//
//  DartView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI
import SpriteKit

struct DartView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isMessagePresented = true
    @StateObject private var dartScene = DartScene()
    @State private var isNavi: Bool = false
    @Binding var firstNaviLinkActive: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteKitContainer(scene: dartScene)
                .edgesIgnoringSafeArea(.all)
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
            .offset(y: 30)
            if isMessagePresented {
                HowToPlay(playImageName: "dartHowToPlay", isMessagePresented: $isMessagePresented)
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
                            .font(.custom("SFPro-Semibold", size: 17))
                        Text("뒤로")
                            .font(.custom("SFPro-Regular", size: 17))
                    }
                    .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("다트 던지기")
                    .font(.custom("SFPro-Semibold", size: 17))
                    .tracking(-0.4)
                    .lineSpacing(20)
                    .foregroundColor(.black)
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

struct DartView_Previews: PreviewProvider {
    static var previews: some View {
        DartView(firstNaviLinkActive: .constant(true))
    }
}
