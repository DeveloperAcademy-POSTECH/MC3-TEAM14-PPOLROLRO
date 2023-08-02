//
//  HowToPlay.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/02.
//

import SwiftUI

struct HowToPlay: View {
    let playImageName : String
    @Binding var isMessagePresented : Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.black)
                .opacity(0.5)
            VStack(spacing: 18) {
                Image(playImageName)
                Button(action: {
                    isMessagePresented = false
                }, label: {
                    Image("xmark")
                        .frame(width: 50, height: 50)
                })
            }
        }
    }
}

struct HowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlay(playImageName: "dartHowToPlay", isMessagePresented: .constant(true))
    }
}
