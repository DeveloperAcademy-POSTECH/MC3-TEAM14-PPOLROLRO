//
//  TemplateCrumpleView4.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TemplateCrumpleView4: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var firstNaviLinkActive: Bool
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("transitionBackImage2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
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
                            Text("4/4")
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Text("사직서를 힘껏 날려 스트레스를 풀고,\n지기를 굴리고, 쏘고, 던져 회사를\n무너뜨려보자!")
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                InteractionSelectView(firstNaviLinkActive: $firstNaviLinkActive)
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

struct TemplateCrumpleView4_Previews: PreviewProvider {
    static var previews: some View {
        TemplateCrumpleView4(firstNaviLinkActive: .constant(true))
    }
}
