//
//  SelectedTemplateView.swift
//  Shoong
//
//  Created by Sup on 2023/07/28.
//

import SwiftUI

struct SelectedTemplateView: View {
    
    @EnvironmentObject var templatesEditorViewModel: TemplatesEditorViewModel
    
    var body: some View {
        
        ZStack{
            
            Color.mint.ignoresSafeArea()
            
            VStack {
                // 아무 글자가 없을때는 전체삭제가 안보이고 글자가 생기면 전체삭제버튼 생김
                if !templatesEditorViewModel.editButtonClicked {
                    if !(templatesEditorViewModel.textBoxes.isEmpty) {
                        HStack {
                            
                            Button {
                                templatesEditorViewModel.removeAllText()
                            } label: {
                                Text("전체삭제")
                            }
                            
                        }.frame(alignment: .trailing)
                    }
                }
                // 하얀색으로 들어가 있는 부분이 TemplatesEditorView
                TemplatesEditorView()
                    .frame(width: 350, height: 500)
                    .background()
            }
            
            // Click me 버튼을 누르면 Text를 수정할 수 있는 TextEditorView
            // 검은 반투명 layer View임
            if templatesEditorViewModel.editButtonClicked {
                TextEditorView()
            }
            
            HStack {
                // TextEditorView가 띄워져있을때는 Click me 버튼 안보임
                if !templatesEditorViewModel.editButtonClicked {
                    Button {
                        templatesEditorViewModel.editButtonClicked.toggle()
                    } label: {
                        Text("Click me")
                    }
                }
            }
        }
    }
}

struct SelectedTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTemplateView()
            .environmentObject(TemplatesEditorViewModel())
    }
}
