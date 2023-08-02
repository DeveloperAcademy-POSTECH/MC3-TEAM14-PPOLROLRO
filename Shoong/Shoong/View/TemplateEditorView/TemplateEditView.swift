//
//  TemplateEditView.swift
//  TestTemplateEdit
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

struct TemplateEditView: View {
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    
    @State private var isWrite: Bool = false
    @State private var isColorSelect: Bool = false
    @State var writeText: String = ""
    @State var fontSize: CGFloat = 20
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
                                templateEditViewModel.textModels.append(TextModel(text: writeText, xAxis: 0, yAxis: -64, color: templateEditViewModel.selectColor, fontSize: fontSize))
                                writeText = ""
                                isColorSelect = false
                                templateEditViewModel.selectColor = .black
                            } label: {
                                Text("완료")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 70)
                        .padding(.horizontal, 20)
                        
                        if isColorSelect {
                            HStack {
                                Spacer()
                                
                                ColorPicker()
                                    .environmentObject(templateEditViewModel)
                            }
                            .padding(.horizontal, 15)
                            .padding(.top, 29)
                            
                        } else {
                            HStack {
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
                            .padding(.top, 29)
                        }

                        Spacer()
                        
                        HStack {
                            Slider(value: $fontSize, in: 12...48, step: 4)
                                .tint(.orange)
                                .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                .frame(height: 20)
                                .offset(y: 100)
                            
                            Spacer()
                        }
                        
                        TextField(text: $writeText, axis: .vertical) {
                        }
                        .font(.system(size: fontSize))
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
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                        }
                    }
                    .offset(x: width * 0.41, y: -height * 0.39)
                    .zIndex(1)
                    
                    TemplateEditer()
                        .environmentObject(templateEditViewModel)
                        .padding(.bottom, 60)
                        .zIndex(0)
                    
                    NavigationLink {
                        TemplateCrumpleView1(firstNaviLinkActive: $firstNaviLinkActive)
                    } label: {
                        Text("날리기 임시 버튼")
                    }

//                    Button {
//                        let renderer = ImageRenderer(content: TemplateEditer().environmentObject(templateEditViewModel))
//
//
//                        if let captureViewToImage = renderer.uiImage {
//                            UIImageWriteToSavedPhotosAlbum(captureViewToImage, nil, nil, nil)
//
//
//                        }
//                    } label: {
//                        Text("캡처")
//                            .font(.title)
//                    }
//                    .offset(y: 300)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct TemplateEditView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateEditView(firstNaviLinkActive: .constant(true))
    }
}
