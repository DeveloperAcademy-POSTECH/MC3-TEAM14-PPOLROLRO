//
//  TemplateCrumpleView1.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TemplateCrumpleView1: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var isInteraction: Bool = false
    @State private var draggedOffset: CGFloat = 50
    @State private var accumulatedOffset: CGFloat = 0.0
    @State private var isScriptCheck: Bool = false
    @State private var isExplanation: Bool = false
    
    @Binding var firstNaviLinkActive: Bool
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backGroundBeige.ignoresSafeArea()
            
            if !isExplanation {
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.5)
                    
                    Image("transitionExplanation")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 246)
                }
                .onTapGesture {
                    isExplanation = true
                }
                .zIndex(20)
                .ignoresSafeArea()
            }
            
            ZStack {
                ZStack {
                    Image("scriptFolder")
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        HStack {
                            Text("1/4")
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        if isScriptCheck {
                            Text("하지만, 쉽지 않다는 것을\n잘 아는 당신은...")
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                        } else {
                            Text("당신은 드디어, 사직서를\n봉투에 담았다!")
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
                                    TemplateCrumpleView2(firstNaviLinkActive: $firstNaviLinkActive)
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
                .opacity(isInteraction ? 1 : 0)
                .offset(y: -height * 0.05)
                
                ZStack(alignment: .top) {
                    Image("PartiallyEditableTemplate0")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width - 40)
                        .zIndex(1)
                        .offset(y: draggedOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if !isInteraction && gesture.translation.height > 0 {
                                        draggedOffset = accumulatedOffset + gesture.translation.height
                                    }
                                }
                                .onEnded { gesture in
                                    if !isInteraction {
                                        accumulatedOffset += gesture.translation.height
                                        
                                        if draggedOffset > UIScreen.main.bounds.height / 3 {
                                            draggedOffset = UIScreen.main.bounds.height / 2
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                isInteraction.toggle()
                                            }
                                        }
                                    }
                                }
                        )
                    
                    Image("envelopeTop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width - 32)
                        .padding(.bottom, -10)
                        .offset(y: UIScreen.main.bounds.height * 0.6)
                        .zIndex(0)
                    
                    Image("envelopeBottom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width - 32)
                        .offset(y: UIScreen.main.bounds.height * 0.66)
                        .zIndex(2)
                }
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
        .onDisappear {
            draggedOffset = 50
            accumulatedOffset = 0
            isInteraction = false
            isScriptCheck = false
        }
    }
}

struct TemplateCrumpleView1_Previews: PreviewProvider {
    static var previews: some View {
        TemplateCrumpleView1(firstNaviLinkActive: .constant(true))
    }
}
