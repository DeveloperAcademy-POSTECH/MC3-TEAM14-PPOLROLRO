//
//  DartView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI

struct DartView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteKitContainer(scene: DartScene())
                .ignoresSafeArea()
            ZStack{
                HStack(alignment: .bottom) {
                    ThrownCount()
                    Spacer()
                    GuageBar()
                }
                .padding(.leading, 19)
                .padding(.trailing, 16)
                .padding(.bottom, 24)
            }
        }
    }
}

struct DartView_Previews: PreviewProvider {
    static var previews: some View {
        DartView()
    }
}
