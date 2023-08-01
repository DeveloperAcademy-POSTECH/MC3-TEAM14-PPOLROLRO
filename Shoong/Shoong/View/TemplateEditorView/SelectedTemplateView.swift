//
//  SelectedTemplateView.swift
//  Shoong
//
//  Created by Sup on 2023/07/28.
//

import SwiftUI

struct SelectedTemplateView: View {
    @EnvironmentObject var templatesEditorViewModel: TemplatesEditorViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var firstNaviLinkActive: Bool
    
    var body: some View {
        ZStack{
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack {
                ZStack {
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Image("forderImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width)
                            
                            // 아무 글자가 없을때는 전체삭제가 안보이고 글자가 생기면 전체삭제버튼 생김
                            if !templatesEditorViewModel.editButtonClicked {
                                if !(templatesEditorViewModel.textBoxes.isEmpty) {
                                    HStack {
                                        Button {
                                            templatesEditorViewModel.removeAllText()
                                        } label: {
                                            Text("전체삭제")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .offset(y: -UIScreen.main.bounds.height / 2.9)
                                }
                            }
                            
                            if !templatesEditorViewModel.editButtonClicked {
                                Button {
                                    templatesEditorViewModel.editButtonClicked.toggle()
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 40)
                                        
                                        Text("Aa")
                                            .font(.system(size: 22))
                                            .foregroundColor(.black)
                                    }
                                }
                                .offset(x: UIScreen.main.bounds.width / 2.46, y: -UIScreen.main.bounds.height / 2.56)
                            }
                            
                            NavigationLink {
                                TemplateCrumpleView1(firstNaviLinkActive: $firstNaviLinkActive)
                            } label: {
                                Text("날리기")
                                    .modifier(ButtonModifier())
                            }
                            .offset(y: UIScreen.main.bounds.height * 0.35)
                        }
                    }
                    .ignoresSafeArea()
                    
                    // 하얀색으로 들어가 있는 부분이 TemplatesEditorView
                    TemplatesEditorView()
                        .frame(width: 350, height: 500)
                        .background()
                }
            }
            
            // Click me 버튼을 누르면 Text를 수정할 수 있는 TextEditorView
            // 검은 반투명 layer View임
            if templatesEditorViewModel.editButtonClicked {
                TextEditorView()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.backward")
                            .fontWeight(.semibold)
                        
                        Text("뒤로")
                    }
                    .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("선택된 사직서")
                    .bold()
            }
        }
    }
}

struct SelectedTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTemplateView(firstNaviLinkActive: .constant(false))
            .environmentObject(TemplatesEditorViewModel())
    }
}

