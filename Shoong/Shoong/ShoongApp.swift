//
//  ShoongApp.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI

@main
struct ShoongApp: App {
    
    // Template 내용작성을 위한 Viewmodel
    @StateObject var model = TemplatesEditorViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
