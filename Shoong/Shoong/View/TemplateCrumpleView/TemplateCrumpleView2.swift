//
//  TemplateCrumpleView2.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TemplateCrumpleView2: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var firstNaviLinkActive: Bool
    
    @State private var isScriptCheck: Bool = false
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack {
                ZStack {
                    Image("scriptFolder")
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        HStack {
                            Text("2/4")
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        if isScriptCheck {
                            Text("참을 수 없는 감정으로\n사직서를 구겨버렸다!")
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                        } else {
                            Text("놀랍게도, 곧 사직서는\n움직이기 시작하는데...")
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                        }
                        
                        Spacer()
                        
                        HStack {
                            NavigationLink {
                                InteractionSelectView(firstNaviLinkActive: $firstNaviLinkActive)
                            } label: {
                                Text("건너뛰기")
                            }
                            
                            Spacer()
                            
                            if isScriptCheck {
                                NavigationLink {
                                    TemplateCrumpleView3(firstNaviLinkActive: $firstNaviLinkActive)
                                } label: {
                                    Text("다음")
                                        .bold()
                                }
                                
                            } else {
                                Button {
                                    isScriptCheck.toggle()
                                } label: {
                                    Text("다음")
                                        .bold()
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 30)
                }
                .font(.system(size: 17))
                .foregroundColor(.fontRed)
                .frame(width: width - 32, height: (width - 32) * 298 / 358)
                .padding(.top, 40)
                
                Spacer()
                
                Image("paper")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 275)
                
                Spacer()
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
                Text("사직서 날리기")
                    .bold()
            }
        }
    }
}

struct TemplateCrumpleView2_Previews: PreviewProvider {
    static var previews: some View {
        TemplateCrumpleView2(firstNaviLinkActive: .constant(true))
    }
}
