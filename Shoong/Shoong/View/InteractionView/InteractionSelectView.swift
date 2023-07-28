//
//  InteractionSelectView.swift
//  MC3_Shoong
//
//  Created by Zerom on 2023/07/24.
//

import SwiftUI

struct InteractionSelectView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isHaptic: Bool = true
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    var interactionNameArr: [String] = ["사직서 날리기", "볼링 던지기", "다트 던지기", "새총 쏘기"]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("스트레스를")
                            .opacity(0.6)
                        
                        Text("쓩!")
                            .foregroundColor(.fontOrange)
                    }
                    
                    Text("날려보세요.")
                        .opacity(0.6)
                }
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.top, 10)
                
                Spacer()
                
                Image("interactionSelectCharacter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width)
                    .padding(.top, 60)
                    .padding(.bottom, -20)
                
                ZStack {
                    ScrollView {
                        ForEach(interactionNameArr, id: \.self) { name in
                            NavigationLink {
                                // 각각 인터렉션 뷰로 네비
                            } label: {
                                InteractionCardView(width: width, interactionName: name)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    VStack {
                        Spacer()
                        
                        Image("backGroundGradation")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width)
                    }
                    .ignoresSafeArea()
                }
                .background(Color.backGroundGray)
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                    
                    Toggle(isOn: $isHaptic) {
                        Text("HAPTIC")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .toggleStyle(MyToggleStyle())
                }
                .frame(width: 113, height: 36)
            }
        }
    }
}

struct InteractionSelectView_Previews: PreviewProvider {
    static var previews: some View {
        InteractionSelectView()
    }
}
