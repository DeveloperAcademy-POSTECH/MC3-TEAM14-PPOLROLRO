//
//  TextEditorView.swift
//  WrappingInstagramEditorView
//
//  Created by Sup on 2023/07/25.
//

import SwiftUI

struct TextEditorView: View {
    @EnvironmentObject var model: TemplatesEditorViewModel
    @FocusState private var focusField: Field?
    
    enum Field: Hashable {
        case textInput
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.60).ignoresSafeArea()

            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        model.finishEditView()
                        model.editButtonClicked = false
                    } label: {
                        Text("완료")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                    }
                }
                .padding(30)
                
                if !model.colorPaintClicked {
                    Button {
                        model.colorPaintClicked.toggle()
                    } label: {
                        Image(systemName: "paintpalette.fill")
                            .foregroundColor(model.selectedColor)
                    }
                } else {
                    TextColorPickerView()
                }
                
                Spacer()
                
                TextField(text: $model.textInput, axis: .vertical) {
                }
                .focused($focusField, equals: .textInput)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .foregroundColor(model.selectedColor)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        .onAppear {
            focusField = .textInput
        }
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
            .environmentObject(TemplatesEditorViewModel())
    }
}
