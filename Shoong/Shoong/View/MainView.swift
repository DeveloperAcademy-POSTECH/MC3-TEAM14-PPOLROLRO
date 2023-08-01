//
//  MainView.swift
//  MC3_Shoong
//
//  Created by Zerom on 2023/07/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var templateSelectViewModel = TemplateSelectViewModel()
    
    @State var isOpenArr: [Bool] = [false, false, false, false, false]
    @State var yAxisArr: [Double] = [0, 0, 0, 0, 0]
    @State var firstNaviLinkActive = false
    
    @State private var currentSelectedIndex: Int = 0
    @State private var offset: CGFloat = 0.0
    @State private var opacity: Double = 0.0
    
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
                                        .font(.system(size: 24, weight: .heavy))
                                    
                                    Text("화요일은 화사하게 웃는날!")
                                        .font(.system(size: 24, weight: .heavy))
                                        .opacity(0.6)
                                }
                                
                                Spacer()
                                
                                NavigationLink {
                                    StorageView()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(Color.white)
                                            .frame(width: 86, height: 36)
                                        
                                        HStack {
                                            Image(systemName: "folder.fill")
                                            Text("보관함")
                                        }
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.black)
                                    }
                                }
                            }
                            
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
                            .font(.system(size: 13, weight: .bold))
                            .padding(.top, 10)
                        }
                        .padding(.top, height * 0.06)
                        .padding(.horizontal, 16)
                        .zIndex(1)
                    }
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
                    .scrollDisabled(true)
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
                    SelectedTemplateView(firstNaviLinkActive: $firstNaviLinkActive)
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
                isOpenArr = [false, false, false, false, false]
            }
        }
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
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(title[index])
                            }
                            .font(.system(size: 17, weight: .bold))
                            
                            Text("사직서 바로 날리기")
                                .font(.system(size: 13))
                                .font(.callout)
                        }
                        .foregroundColor(titleColor[index])
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    .zIndex(2)
                }
                
                Spacer()
            }
            .zIndex(1)
            
            VStack {
                Rectangle()
                    .opacity(0.0)
                    .frame(height: 48)
                
                ZStack(alignment: .top) {
                    if index == 4 {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(height: height * 0.18)
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



