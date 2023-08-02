//
//  ContentView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    @EnvironmentObject var templateSelectViewModel: TemplateSelectViewModel
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @State private var isViewChanger: Bool = false
    
    var body: some View {
        if isViewChanger {
            MainView()
                .environmentObject(templateEditViewModel)
                .environmentObject(templateSelectViewModel)
                .environmentObject(coreDataViewModel)
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
