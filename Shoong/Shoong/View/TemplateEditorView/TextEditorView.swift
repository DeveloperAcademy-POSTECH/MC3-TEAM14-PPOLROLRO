//
//  TextEditorView.swift
//  Shoong
//
//  Created by Sup on 2023/07/28.
//

import SwiftUI


// 이 View가 아마 제일 layout이 엉망인 상태입니다..
struct TextEditorView: View {

    @EnvironmentObject var templatesEditorViewModel: TemplatesEditorViewModel

    var body: some View {

        ZStack {
            Color.black.opacity(0.60)
                .ignoresSafeArea()

            VStack {
                VStack{
                    HStack {

                        Spacer()
                        //완료버튼 누르면 finishEditView 내용처럼 글자저장시키고
                        // 문자열 초기화 + 빈문자열 거르기
                        Button {
                            templatesEditorViewModel.finishEditView()
                            templatesEditorViewModel.editButtonClicked = false
                        } label: {
                            Text("완료")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                        }
                        .padding()
                        .padding()
                    }
                    // paintpalette 아이콘 보이다가 버튼 누르면 색상목록(TextColorPicker) 보여주기
                    if !templatesEditorViewModel.colorPaintClicked {
                        Button {
                            templatesEditorViewModel.colorPaintClicked.toggle()
                        } label: {
                            Image(systemName: "paintpalette.fill")
                                .foregroundColor(templatesEditorViewModel.selectedColor) // 선택한 색상으로 팔레트 색상도 변경
                        }
                    } else {
                        TextColorPickerView()
                    }
                    Spacer()
                }
                Spacer()
            }

            VStack{
                // 글자입력부분이 키보드에 안가리는 위치를 찾아서 넣어놓은건데
                // 다른 뷰안에 들어가면서 위치가 바뀌어서 수정필요하면 해도 됩니다.
                Spacer(minLength: UIScreen.main.bounds.width / 1.2  )

                ZStack{
                    // placeholder구현이 TextEditor자체에서는 안되고 무조건 TextView써야해서 임시방편으로 placeholder의 느낌을 줄 수 있게 해놓음
                    if templatesEditorViewModel.textInput.isEmpty {
                            VStack{
                                Text("내용을 입력해주세요.")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        TextEditor(text: $templatesEditorViewModel.textInput)
                        .foregroundColor(templatesEditorViewModel.selectedColor)
                        .multilineTextAlignment(.center)
                        .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
            .environmentObject(TemplatesEditorViewModel())
    }
}
