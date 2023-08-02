//
//  TemplateEditView.swift
//  TestTemplateEdit
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

struct TemplateEditView: View {
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    @EnvironmentObject var templateSeletViewModel: TemplateSelectViewModel
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) var displayScale
    
    @State private var isWrite: Bool = false
    @State private var isColorSelect: Bool = false
    @State var writeText: String = ""
    @State var fontSize: CGFloat = 24
    @Binding var firstNaviLinkActive: Bool
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @FocusState private var focusField: Field?
    
    enum Field: Hashable {
        case textInput
    }
    
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            if isWrite {
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button {
                                isWrite.toggle()
                                templateEditViewModel.textModels.append(TextModel(text: writeText, xAxis: 0, yAxis: -42, color: templateEditViewModel.selectColor, fontSize: fontSize))
                                writeText = ""
                                isColorSelect = false
                                templateEditViewModel.selectColor = .black
                            } label: {
                                Text("완료")
                                    .font(.custom("SFPro-Bold", size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 64)
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Spacer()
                            
                            if isColorSelect {
                                ColorPicker()
                                    .environmentObject(templateEditViewModel)
                                    .padding(.horizontal, 15)
                            }
                            
                            Spacer()
                            
                            Button {
                                isColorSelect.toggle()
                            } label: {
                                Image("colorSelecter")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 9)

                        Spacer()
                        
                        HStack {
                            Slider(value: $fontSize, in: 16...48, step: 2)
                                .tint(.orange)
                                .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                .frame(height: 20)
                                .offset(y: 100)
                            
                            Spacer()
                        }
                        
                        TextField(text: $writeText, axis: .vertical) {
                        }
                        .font(.custom("SFPro-Bold", size: fontSize))
                        .foregroundColor(templateEditViewModel.selectColor)
                        .focused($focusField, equals: .textInput)
                        .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                }
                .zIndex(2)
             }
            
            VStack {
                Spacer()
                
                ZStack {
                    Image("forderImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                        .zIndex(0)
                    
                    Button {
                        isWrite.toggle()
                        focusField = .textInput
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 40)
                            
                            Text("Aa")
                                .font(.custom("SFPro-Regular", size: 22))
                                .foregroundColor(.black)
                        }
                    }
                    .offset(x: width * 0.41, y: -height * 0.39)
                    .zIndex(1)
                    
                    TemplateEditer()
                        .environmentObject(templateEditViewModel)
                        .environmentObject(templateSeletViewModel)
                        .padding(.bottom, 60)
                        .zIndex(0)
                    
                    NavigationLink {
                        TemplateCrumpleView1(firstNaviLinkActive: $firstNaviLinkActive)
                            .environmentObject(coreDataViewModel)
                    } label: {
                        Text("날리기")
                            .modifier(ButtonModifier())
                    }
                    .offset(y: width * 0.76)
                }
            }
            .ignoresSafeArea()
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
        .onDisappear {
            coreDataViewModel.addTemplate(templateImageD: TemplateEditer().environmentObject(templateEditViewModel).environmentObject(templateSeletViewModel), scale: displayScale)
        }
    }
}

struct TemplateEditView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateEditView(firstNaviLinkActive: .constant(true))
    }
}
