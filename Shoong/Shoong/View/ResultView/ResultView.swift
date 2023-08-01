//
//  CardView.swift
//  MC3_Shoong
//
//  Created by Zerom on 2023/07/24.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    @State var backGroundColor: Color = .white
    @State var isTurn: Bool = false
    @State var angle: Double = 0
    @Binding var firstNaviLinkActive: Bool
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            backGroundColor.ignoresSafeArea()
            
            VStack {
                CardView(backGroundColor: $backGroundColor, isTurn: $isTurn, width: width * 0.9)
                    .frame(height: height * 0.6)
                    .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
                    .animation(.easeInOut(duration: 0.6), value: angle)
                    .onTapGesture {
                        angle += 180
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isTurn.toggle()
                        }
                    }
                
                Spacer()
                
                Button {
                    // 메인으로 가도록
                    firstNaviLinkActive.toggle()
                } label: {
                    Text("메인으로 가기")
                        .modifier(ButtonModifier(backgroundColor: backGroundColor == .pointGreen ? .pointYellow : .pointGreen, foregroundColor: backGroundColor == .pointGreen ? .black : .white))
                }
                .padding(.top, 10)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        // 앨범에 저장
                    } label: {
                        Text("앨범에 저장")
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.pointBlue)
                        .frame(width: 1, height: 17)
                    
                    Spacer()
                    
                    NavigationLink {
                        // 보관함으로 이동
                        StorageView()
                    } label: {
                        Text("보관함 가기")
                    }
                    
                    Spacer()
                }
                .font(.system(size: 17))
            }
            .padding(.vertical, 20)
            .padding(.top, 10)
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
                Text("보상 카드")
                    .bold()
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(firstNaviLinkActive: .constant(true))
    }
}

struct CardView: View {
    var cardBackArr = ["cardBack1", "cardBack2", "cardBack3", "cardBack4"]
    var cardCharacterArr = ["character1", "character2", "character3", "character4"]
    @State private var randomCardBack: String = "cardBack1"
    @Binding var backGroundColor: Color
    @Binding var isTurn: Bool
    @State private var fontColor: Color = .blue
    var width: CGFloat
    let ratio: Double = (UIImage(named: "cardBack1")?.size.height ?? 0) / (UIImage(named: "cardBack1")?.size.width ?? 0)
    
    var body: some View {
        ZStack {
            Image(randomCardBack)
                .resizable()
                .scaledToFit()
            
            if isTurn {
                Image("PartiallyEditableTemplate0")
                    .resizable()
                    .scaledToFit()
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                ZStack {
                    VStack {
                        HStack {
                            Text("07")
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text("13")
                        }
                        .padding(.bottom, -50)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("나는 오늘 83번의")
                                Text("사직서를 날렸습니다.")
                            }
                            .font(.system(size: 25, weight: .bold))
                            
                            Spacer()
                        }
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 210, weight: .bold))
                    .zIndex(0)
                    .offset(y: -20)
                    
                    Image(cardCharacterArr.randomElement() ?? "character1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.7)
                        .zIndex(1)
                }
                .foregroundColor(fontColor)
                .padding(20)
            }
        }
        .frame(width: width, height: ratio * width)
        .onAppear{
            randomCardBack = cardBackArr.randomElement() ?? "cardBack1"
            switch randomCardBack {
            case "cardBack1":
                backGroundColor = .pointGreen
            case "cardBack3":
                backGroundColor = .pointGray
            case "cardBack2":
                fontColor = .white
            default:
                backGroundColor = .white
            }
        }
    }
}

