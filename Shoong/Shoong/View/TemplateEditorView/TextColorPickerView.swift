//
//  TextColorPicker.swift
//  Shoong
//
//  Created by Sup on 2023/07/28.
//

import SwiftUI

struct TextColorPickerView: View {
    @EnvironmentObject var templatesEditorViewModel: TemplatesEditorViewModel

    private let colors:[Color] = [ .white ,.black, .red, .orange, .yellow, .green, .blue]

    var body: some View {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 25, height: 25)
                        .opacity(color == templatesEditorViewModel.selectedColor ? 0.5 : 1.0)
                        .scaleEffect(color == templatesEditorViewModel.selectedColor ? 1.1 : 1.0)
                        .onTapGesture {
                            templatesEditorViewModel.selectedColor = color
                            templatesEditorViewModel.colorPaintClicked.toggle()
                        }
                }

            }
            .padding()
    }
}
