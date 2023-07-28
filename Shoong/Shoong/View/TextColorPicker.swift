//
//  TextColorPicker.swift
//  Shoong
//
//  Created by Sup on 2023/07/28.
//

import SwiftUI

struct TextColorPicker: View {

    @EnvironmentObject var model: TemplatesEditorViewModel

    private let colors:[Color] = [ .white ,.black, .red, .orange, .yellow, .green, .blue]



    var body: some View {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 25, height: 25)
                        .opacity(color == model.selectedColor ? 0.5 : 1.0)
                        .scaleEffect(color == model.selectedColor ? 1.1 : 1.0)
                        .onTapGesture {
                            model.selectedColor = color
                            model.colorPaintClicked.toggle()
                        }
                }

            }
            .padding()
    }
}
