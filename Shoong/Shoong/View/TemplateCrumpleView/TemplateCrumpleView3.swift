//
//  TemplateCrumpleView3.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TemplateCrumpleView3: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var firstNaviLinkActive: Bool
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("transitionBackImage1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 600)
            }
            .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Image("scriptFolder")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.95)
                    
                    VStack {
                        HStack {
                            Text("3/4")
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Text("그렇게 탄생한 '지기'는 회사를 향한\n작은 혁명을 시작한다!!")
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        HStack {
                            NavigationLink {
                                InteractionSelectView(firstNaviLinkActive: $firstNaviLinkActive)
                            } label: {
                                Text("건너뛰기")
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                TemplateCrumpleView4(firstNaviLinkActive: $firstNaviLinkActive)
                            } label: {
                                Text("다음")
                                    .bold()
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

struct TemplateCrumpleView3_Previews: PreviewProvider {
    static var previews: some View {
        TemplateCrumpleView3(firstNaviLinkActive: .constant(true))
    }
}
