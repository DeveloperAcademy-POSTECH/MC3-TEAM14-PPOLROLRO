////
////  TextDragGesture.swift
////  Shoong
////
////  Created by Sup on 2023/07/28.
////
//
//import SwiftUI
//
//struct TextDragGestureView: View {
//
//    @EnvironmentObject var templatesEditorViewModel: TemplatesEditorViewModel
//
//    @State private var position = CGSize.zero
//    @GestureState private var dragOffset = CGSize.zero
//
//    var textBox: TextBoxModel
//
//    var body: some View {
//
//        Text(textBox.text)
//            .foregroundColor(textBox.textColor)
//            .padding()
//            // 밑의 onEnded 위치값도 마찬가지인데 SelectedTemplateView내의 글씨 표시부분인 TemplatesEditorView 만큼 사이즈를 절대값으로 잡은것
//            // SelectedTemplateView에서 표시되는 크기가 layout에 따라 달라질 수 있어서 TemplatesEditorView의 frame에 따른 상대값으로 조정필요해보임
//            .offset(
//                x: max(-130, min(130, position.width + dragOffset.width)),
//                y: max(-50, min(400, position.height + dragOffset.height))
//            )
//            .gesture(
//                TapGesture()
//                    .onEnded { _ in
//                        // 글자를 터치만 했을 때 수정할 수 있게 해당 글자만 가지고 TextEditorView로 진입
//                        templatesEditorViewModel.selectedTextBox = textBox
//                        templatesEditorViewModel.editSelectedTextBox()
//
//                    }
//                    .simultaneously(with:
//                                        DragGesture()
//                                            .updating($dragOffset, body: { (value, state, _) in
//                                                state = value.translation
//                                            })
//                                            //offset부분과 동일
//                                            .onEnded({ value in
//                                                self.position.width = max(-130, min(130, self.position.width + value.translation.width))
//                                                self.position.height = max(-50, min(400, self.position.height + value.translation.height))
//
//                                            })
//                                   )
//            )
//    }
//}
