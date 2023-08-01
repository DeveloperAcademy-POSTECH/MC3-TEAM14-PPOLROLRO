//
//  SplashView.swift
//  Shoong
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            Image("splashViewImage")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
