//
//  StorageView.swift
//  Shoong
//
//  Created by Zerom on 2023/07/29.
//

import SwiftUI

struct StorageView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @Environment(\.dismiss) private var dismiss
//    var cards: [String] = ["testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage"]
    @State private var width: CGFloat = UIScreen.main.bounds.width - 20
    @State private var height: CGFloat = UIScreen.main.bounds.height
    @State private var yAxis: CGFloat = 16
    @State private var mainIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.backGroundBeige.ignoresSafeArea()
            
            VStack {
                Rectangle()
                    .fill(Color.backGroundBeige)
                    .frame(height: 100)

                Spacer()
            }
            .ignoresSafeArea()
            .zIndex(20)
            
            ForEach(0..<coreDataViewModel.pairsSavedEntities.count) { index in
                CardStackView(mainIndex: mainIndex, index: index, card: coreDataViewModel.pairsSavedEntities[index].cardImageD, width: width)
                    .offset(y: yAxis + CGFloat(index * (index - 50)) < 17 ? yAxis + CGFloat(index * (index - 50)) : height * 0.66)
                    .animation(.easeInOut(duration: 0.6), value: yAxis)
                    .opacity(yAxis + CGFloat(index * (index - 50)) < 70 ? 1 : 0)
            }
            .gesture(
                DragGesture()
                    .onEnded({ gesture in
                        if gesture.translation.height > 0 && yAxis < 16 + CGFloat((coreDataViewModel.pairsSavedEntities.count - 1) * 40) {
                            yAxis += 40
                            width += 30
                            mainIndex += 1
                        } else if gesture.translation.height < 0 && yAxis > 16 {
                            yAxis -= 40
                            width -= 30
                            mainIndex -= 1
                        }
                    })
            )
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
                Text("보관함")
                    .bold()
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}

struct CardStackView: View {
    @State private var angle: Double = 0.0
    var mainIndex: Int
    var index: Int
    var card: Data
    var width: CGFloat
    
    var body: some View {
        Image(uiImage: UIImage(data: card) ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: width - 40 - CGFloat(index * 30))
            .zIndex(Double(10 - index))
            .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
            .animation(.easeInOut(duration: 0.6), value: angle)
            .onTapGesture {
                if index == mainIndex {
                    angle += 180
                }
            }
    }
}

