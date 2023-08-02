//
//  ContentView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    @State private var isViewChanger: Bool = false
    
    var body: some View {
        if isViewChanger {
            MainView()
                .environmentObject(templateEditViewModel)
        } else {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isViewChanger.toggle()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
