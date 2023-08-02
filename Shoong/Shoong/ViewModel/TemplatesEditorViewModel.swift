////
////  DirTestView3.swift
////  Shoong
////
////  Created by Sup on 2023/07/27.
////
//
//import SwiftUI
//
//class TemplatesEditorViewModel: ObservableObject {
//    
//    @Published var editButtonClicked = false
//    @Published var textInput:String = ""
////    @Published var textBoxes: [TextBoxModel] = []
////    
////    @Published var selectedTextBox: TextBoxModel?
//    
//    
//    @Published var colorPaintClicked = false
//    @Published var selectedColor: Color = .white
//    
//    
//    
//    // TextEditorView가 나온화면에서 완료버튼을 눌렀을 때
//    func finishEditView(){
//        
//        if !(textInput == "") {
//            // text는 TextBoxModel을 배열의 형태로 textBoxes에 넣어주는 방식으로 구현
//            let text = TextBoxModel(text: textInput,textColor: selectedColor)
//            textBoxes.append(text)
//            editButtonClicked.toggle()
//            textInput = "" // 마지막에 항상 빈 String으로 초기화
//            
//        }
//        
//    }
//    
//    
//    func removeAllText(){
//        textBoxes.removeAll()
//        textInput = ""
//    }
//    
//    
//    
//    func editSelectedTextBox() {
//        
//        // 선택한 index값에 대해서만 글자 수정
//        if let box = selectedTextBox, let index = textBoxes.firstIndex(where: { $0.id == box.id }) {
//            textInput = box.text
//            selectedColor = box.textColor
//            editButtonClicked = true
//            textBoxes.remove(at: index)
//        }
//    }
//}
