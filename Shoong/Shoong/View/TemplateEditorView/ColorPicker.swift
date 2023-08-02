//
//  ColorPicker.swift
//  TestTemplateEdit
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

struct ColorPicker: View {
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    
    private let colors:[Color] = [ .white ,.black, .red, .orange, .yellow, .green, .blue]
        
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 30, height: 30)
                    .opacity(color == templateEditViewModel.selectColor ? 0.5 : 1.0)
                    .scaleEffect(color == templateEditViewModel.selectColor ? 1.1 : 1.0)
                    .onTapGesture {
                        templateEditViewModel.selectColor = color
                    }
            }
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker()
    }
}
