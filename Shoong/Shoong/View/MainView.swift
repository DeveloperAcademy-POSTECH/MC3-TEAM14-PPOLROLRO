//
//  MainView.swift
//  MC3_Shoong
//
//  Created by Zerom on 2023/07/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var templateSelectViewModel = TemplateSelectViewModel()
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    
    @State var isOpenArr: [Bool] = [false, true, false, false, false]
    @State var yAxisArr: [Double] = [0, 0, UIScreen.main.bounds.height * 0.46, UIScreen.main.bounds.height * 0.6, UIScreen.main.bounds.height * 0.6]
    @State var firstNaviLinkActive = false
    
    @State private var currentSelectedIndex: Int = 1
    @State private var offset: CGFloat = -UIScreen.main.bounds.height * 0.102
    @State private var opacity: Double = 1.0
    
    let colorArr: [Color] = [.pointGreen, .pointOrange, .pointYellow, .pointBlue, .pointGray]
    let height: CGFloat = UIScreen.main.bounds.height
    let width: CGFloat = UIScreen.main.bounds.width
    let ratio: CGFloat = 464 / 348
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.backGroundBeige)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("주말까지 4일")
                                    
                                    Text("필승, YES I CAN!")
                                        .opacity(0.6)
                                }
                                .font(.custom("SFPro-Bold", size: 24))
                                
                                Spacer()
                                
                                NavigationLink {
                                    StorageView()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(Color.pointGray)
                                            .frame(width: 86, height: 36)
                                        
                                        HStack {
                                            Image(systemName: "folder.fill")
                                            Text("보관함")
                                        }
                                        .font(.custom("SFPro-Semibold", size: 13))
                                        .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(.top, 18)
                            
                            VStack(spacing: 6) {
                                ZStack {
                                    Image("character")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 42)
                                        .zIndex(1)
                                    
                                    Image("mountain")
                                        .resizable()
                                        .scaledToFit()
                                        .zIndex(0)
                                }
                                
                                HStack {
                                    Text("월")
                                    
                                    Spacer()
                                    
                                    Text("금")
                                }
                            }
                            .foregroundColor(.fontWhiteGray)
                            .font(.custom("SFPro-Bold", size: 13))
                        } // VStack
                        .padding(.top, height * 0.06)
                        .padding(.horizontal, 16)
                        .zIndex(1)
                    } // ZStack
                    .frame(height: height * 0.3)
                    .padding(.bottom, 0.4)
                    .background(Color.gray)
                    .ignoresSafeArea()
                    
                    Spacer()
                } // VStack
                .zIndex(1)
                
                ScrollView {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.backGroundGray)
                            .frame(height: height * 0.3)
                        
                        ZStack {
                            ForEach(0..<5) { index in
                                FolderView(isOpenArr: $isOpenArr, yAxisArr: $yAxisArr, firstNaviLinkAction: $firstNaviLinkActive, color: colorArr[index], imageName: "folder\(index)", index: index)
                                    .offset(y: Double(Double(index) * height * 0.102) + yAxisArr[index])
                                    .animation(.easeInOut(duration: 0.3), value: yAxisArr)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                    .offset(y: offset)
                    .animation(.easeInOut(duration: 0.3), value: offset)
                    .onChange(of: isOpenArr, perform: { newValue in
                        if isOpenArr[0] {
                            currentSelectedIndex = 0
                            opacity = 1
                        } else if isOpenArr[1] {
                            offset = -height * 0.102
                            currentSelectedIndex = 1
                            opacity = 1
                        } else if isOpenArr[2] {
                            offset = -height * 0.204
                            currentSelectedIndex = 2
                            opacity = 1
                        } else if isOpenArr[3] {
                            offset = -height * 0.306
                            currentSelectedIndex = 3
                            opacity = 1
                        } else if !isOpenArr.contains(true) {
                            offset = 0
                            opacity = 0
                        }
                    })
                }
                .ignoresSafeArea()
                .background(Color.backGroundGray)
                .scrollDisabled(true)
                .zIndex(0)
                
                TabView {
                    ForEach(templateSelectViewModel.templates[currentSelectedIndex], id: \.self) { arr in
                        Image(arr)
                            .resizable()
                            .scaleEffect(y: opacity == 1 ? 1 : 0, anchor: .top)
                            .animation(.easeInOut(duration: 0.2), value: opacity)
                    }
                }
                .frame(width: width - 40, height: (width - 40) * ratio)
                .tabViewStyle(.page)
                .offset(y: height * 0.18)
                .zIndex(3)
                .opacity(opacity)
                .animation(.easeInOut(duration: 0.5), value: opacity)
                
                NavigationLink(isActive: $firstNaviLinkActive) {
                    TemplateEditView(firstNaviLinkActive: $firstNaviLinkActive)
                        .environmentObject(templateEditViewModel)
                } label: {
                    Text("바로 날리기")
                        .modifier(ButtonModifier())
                }
                .opacity(opacity)
                .offset(y: height * 0.4)
                .zIndex(4)
            } // ZStack
            .onAppear {
                firstNaviLinkActive = false
            }
            .onDisappear {
                // isOpenArr = [false, true, false, false, false]
            }
        } // NavigationView
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct FolderView: View {
    @Binding var isOpenArr: [Bool]
    @Binding var yAxisArr: [Double]
    @Binding var firstNaviLinkAction: Bool
    var color: Color
    var imageName: String
    var index: Int
    
    let height: CGFloat = UIScreen.main.bounds.height
    let title: [String] = ["최근", "바로 날리기", "빈칸 채우기", "사직서 만들기", "그냥 즐기기"]
    let script: [String] = ["그때 그 사직서를 다시 날려보세요!", "이미 완성된 사직서를 바로 날려보세요!", "채우고 싶은 부분만 채워서 날려보세요!", "내가 직접 쓴 사직서를 날려보세요!", "사직서를 쓰지 않고 빠르게 날려보세요!"]
    let titleColor: [Color] = [.fontGreen, .fontBurgundy, .fontRed, .fontBlue, .fontBlack]
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    if index == 4 {
                        Button {
                            firstNaviLinkAction.toggle()
                        } label: {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .zIndex(1)
                        }
                    } else {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                isOpenArr[index].toggle()
                            }
                            .zIndex(1)
                    }
                    
                    HStack {
                        Text(title[index])
                            .font(.custom("SFPro-Bold", size: 17))
                            .foregroundColor(titleColor[index])
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .zIndex(2)
                    
                    if isOpenArr[index] {
                        HStack {
                            Text(script[index])
                                .font(.custom("SFPro-Regular", size: 13))
                                .foregroundColor(titleColor[index])
                                .offset(y: 36)
                            
                            Spacer()
                        }
                        .zIndex(2)
                        .padding(.leading, 24)
                    }
                }
                
                Spacer()
            }
            .zIndex(1)
            
            VStack {
                Rectangle()
                    .opacity(0.0)
                    .frame(height: 48)
                    .zIndex(0)
                
                ZStack(alignment: .top) {
                    if index == 4 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color)
                                .frame(height: height * 0.18)
                            
                            Text(script[4])
                                .font(.custom("SFPro-Regular", size: 13))
                                .foregroundColor(titleColor[index])
                                .offset(x: -60, y: 40)
                            
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(titleColor[index])
                                .font(.custom("SFPro-Semibold", size: 17))
                                .offset(x: 150, y: -60)
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(height: isOpenArr[index] ? height * 0.7 : height * 0.18)
                            .animation(.easeInOut(duration: isOpenArr[index] ? 0.1 : 0.4), value: isOpenArr[index])
                            .scaleEffect(anchor: .top)
                    }
                }
                
                Spacer()
            }
            .zIndex(0)
        }
        .onChange(of: isOpenArr[index]) { _ in
            if isOpenArr[index] {
                let min = index + 1
                
                for i in min...4 {
                    if i == min {
                        yAxisArr[i] = UIScreen.main.bounds.height * 0.46
                    } else {
                        yAxisArr[i] = UIScreen.main.bounds.height * 0.6
                    }
                }
            } else {
                yAxisArr = [0, 0, 0, 0, 0]
            }
        }
    }
}



