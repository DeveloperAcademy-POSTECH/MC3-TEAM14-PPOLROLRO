//
//  TemplateCrumpleView1.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TemplateCrumpleView1: View {
    @State private var isNavigation: Bool = false
    @State private var draggedOffset: CGFloat = 50
    @State private var accumulatedOffset: CGFloat = 0.0
    @State private var textOpacity: Double = 1.0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack {
                Image("crumpleFolder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                
                ZStack(alignment: .top) {
                    Image("testTemplate")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.65)
                        .zIndex(1)
                        .offset(y: draggedOffset)
                        .gesture(
                            DragGesture()
                              .onChanged { gesture in
                                  if gesture.translation.height > 0 {
                                      draggedOffset = accumulatedOffset + gesture.translation.height
                                      
                                      textOpacity = 0.0
                                  }
                              }
                              .onEnded { gesture in
                                  accumulatedOffset += gesture.translation.height
                                  
                                  if draggedOffset > UIScreen.main.bounds.height / 3 {
                                      print("@Log")
                                      draggedOffset = UIScreen.main.bounds.height / 2
                                      
                                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                          isNavigation.toggle()
                                      }
                                  }
                              }
                        )
                    
                    NavigationLink(destination: TemplateCrumpleView2(), isActive: $isNavigation) {
                        Text(".")
                            .foregroundColor(.clear)
                    }
                    
                    Text("사직서를 밀어서\n봉투 안으로 넣어보세요.")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .zIndex(2)
                        .opacity(textOpacity)
                        .padding(.top, UIScreen.main.bounds.height / 4)
                    
                    Image("envelopeTop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.66)
                        .padding(.bottom, -10)
                        .offset(y: UIScreen.main.bounds.height * 0.5)
                        .zIndex(0)
                    
                    Image("envelopeBottom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.66)
                        .offset(y: UIScreen.main.bounds.height * 0.544)
                        .zIndex(2)
                    
                    Image("downButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72)
                        .offset(y: UIScreen.main.bounds.height * 0.52)
                        .zIndex(3)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("1/4")
                    .foregroundColor(.blue)
            }
        }
        .onAppear {
            draggedOffset = 50
            accumulatedOffset = 0
        }
    }
}

struct TemplateCrumpleView1_Previews: PreviewProvider {
    static var previews: some View {
        TemplateCrumpleView1()
    }
}
