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
        ZStack{
            // textBoxes에 있는 글자들 1개씩 Box로 꺼내서 화면에 표시
            ForEach(templatesEditorViewModel.textBoxes) { Box in
//                TextDragGestureView(textBox: Box)
//                .shadow(color: .black, radius: 5,x: 1,y: 1)
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
