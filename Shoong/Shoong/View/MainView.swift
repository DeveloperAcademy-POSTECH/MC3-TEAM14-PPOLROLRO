//
//  MainView.swift
//  MC3_Shoong
//
//  Created by Zerom on 2023/07/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var templateModel = TemplateModel()
    @State var yAxisArr: [Double] = [0, 0, 0, 0, 0]
    @State var isOpen: Bool = false
    var colorArr: [Color] = [.pointGreen, .pointOrange, .pointYellow, .pointBlue, .pointGray]
    @State private var draggedOffset: CGFloat = 0.0
    @State private var accumulatedOffset: CGFloat = 0.0
    @State private var pageIndex: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.backGroundBeige)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("주말까지 4일")
                                .font(.system(size: 24, weight: .heavy))
                            
                            Text("화요일은 화사하게 웃는날!")
                                .font(.system(size: 24, weight: .heavy))
                                .opacity(0.6)
                            
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
                        .padding(.top, UIScreen.main.bounds.height * 0.06)
                        .padding(.horizontal, 16)
                        .zIndex(1)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .padding(.bottom, 0.4)
                    .background(Color.gray)
                    .ignoresSafeArea()
                    
                    Spacer()
                }
                .zIndex(1)
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.backGroundGray)
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                        
                        ScrollView {
                            ScrollViewReader { proxy in
//                                HStack {
//                                    Button("test0") {
//                                        proxy.scrollTo(0, anchor: .top)
//                                    }
//
//                                    Button("tes1") {
//                                        proxy.scrollTo(1, anchor: .top)
//                                    }
//
//                                    Button("test2") {
//                                        proxy.scrollTo(2, anchor: .top)
//                                    }
//                                }
                                
                            ZStack {
                                ForEach(0..<5) { index in
                                    FolderView(yAxisArr: $yAxisArr, isOpen: $isOpen, index: index, imageName: "folder\(index)", color: colorArr[index])
                                        .offset(y: Double(Double(index) * UIScreen.main.bounds.height * 0.102) + yAxisArr[index])
                                        .animation(.easeInOut(duration: 0.3), value: yAxisArr)
                                }
                                
                                if isOpen {
                                    VStack {
                                        ForEach(0..<4) { index in
                                            TabView {
                                                ForEach(templateModel.templates[index], id: \.self) { arr in
                                                    Image(arr)
                                                        .resizable()
                                                }
                                            }
                                            .zIndex(Double(index + 5))
                                            .tabViewStyle(.page)
                                            .frame(width: UIScreen.main.bounds.width - 40, height: (UIScreen.main.bounds.width - 40) * 464 / 348)
                                            .padding(.top, 10)
                                        }
                                    }
                                    .padding(.top, 60)
                                    
                                    VStack {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 1)
                                            .id(0)

                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 300)

                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 1)
                                            .id(1)

                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 600)

                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 1)
                                            .id(2)

                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 900)
                                    }
                                    .zIndex(20)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        }
                    }
                    .scrollDisabled(true)
                }
                .ignoresSafeArea()
                .background(Color.backGroundGray)
                .zIndex(0)
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
    @Binding var yAxisArr: [Double]
    @Binding var isOpen: Bool
    var index: Int
    var imageName: String
    var color: Color
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            isOpen.toggle()
                        }
                        .zIndex(1)
                    
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            if index == 4 {
                                HStack {
                                    Text("바로가기")
                                    
                                    Image(systemName: "arrow.up.right")
                                }
                                .font(.system(size: 17, weight: .bold))
                            } else {
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.fontRed)
                                        .padding(.trailing, 10)
                                    
                                    Text("템플릿 \(index + 1)")
                                }
                                .font(.system(size: 17, weight: .bold))
                            }
                            
                            Text("사직서 바로 날리기")
                                .font(.system(size: 13))
                                .font(.callout)
                        }
                        .foregroundColor(.fontGray)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 6)
                    .zIndex(2)
                }
                
                Spacer()
            }
            .zIndex(1)
            
            VStack {
                Rectangle()
                    .opacity(0.0)
                    .frame(height: 50)
                
                ZStack(alignment: .top) {
                    if index == 4 {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(height: UIScreen.main.bounds.height * 0.18)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(height: isOpen ? UIScreen.main.bounds.height * 0.7 : UIScreen.main.bounds.height * 0.18)
                            .animation(.easeInOut(duration: isOpen ? 0.1 : 0.4), value: isOpen)
                            .scaleEffect(anchor: .top)
                    }
                }
                
                Spacer()
            }
            .zIndex(0)
        }
        .onChange(of: isOpen) { _ in
            if isOpen {
                yAxisArr = [0, UIScreen.main.bounds.height * 0.46, UIScreen.main.bounds.height * 0.46 * 2, UIScreen.main.bounds.height * 0.46 * 3, UIScreen.main.bounds.height * 0.46 * 4]
            }else {
                yAxisArr = [0, 0, 0, 0, 0]
            }
        }
    }
}


