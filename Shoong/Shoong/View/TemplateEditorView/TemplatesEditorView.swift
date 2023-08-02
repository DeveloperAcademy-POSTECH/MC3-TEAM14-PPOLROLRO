//
//  TemplatesEditorView.swift
//  WrappingInstagramEditorView
//
//  Created by Sup on 2023/07/25.
//

import SwiftUI

struct TemplatesEditorView: View {
    @EnvironmentObject var model: TemplatesEditorViewModel
    @State private var position = CGSize.zero
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            Image("PartiallyEditableTemplate0")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .zIndex(0)
            
            ForEach(model.textBoxes) { Box in
                TextDragGesture(position: $position, dragOffset: $dragOffset, textBox: Box)
                    .environmentObject(model)
                    .offset(
                        x: max(-130, min(130, position.width + dragOffset.width)),
                        y: max(-50, min(400, position.height + dragOffset.height))
                    )
                    .zIndex(1)
            }
        }
    }
}

struct TemplatesEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TemplatesEditorView()
            .environmentObject(TemplatesEditorViewModel())
    }
}

struct TextDragGesture: View {
    @EnvironmentObject var model: TemplatesEditorViewModel
    @Binding var position: CGSize
    @Binding var dragOffset: CGSize
    var textBox: TextBoxModel
    
    var body: some View {
        Text(textBox.text)
            .foregroundColor(textBox.textColor)
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        model.selectedTextBox = textBox
                        model.editSelectedTextBox()
                    }
                    .simultaneously(with: DragGesture()
                        .onChanged { newValue in
                            position.width = dragOffset.width + newValue.translation.width
                            position.height = dragOffset.height + newValue.translation.height
                        }
                        .onEnded({ value in
                            self.position.width = max(-130, min(130, self.position.width + value.translation.width))
                            self.position.height = max(-50, min(400, self.position.height + value.translation.height))
                    })))
    }
}
