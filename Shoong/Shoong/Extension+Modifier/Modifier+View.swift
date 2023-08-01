//
//  Modifier+View.swift
//  Shoong
//
//  Created by Zerom on 2023/08/01.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    var backgroundColor: Color = .black
    var foregroundColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(foregroundColor)
            .frame(width: 334, height: 54)
            .background(backgroundColor)
            .cornerRadius(12)
    }
}
