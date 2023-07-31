//
//  StorageView.swift
//  Shoong
//
//  Created by Zerom on 2023/07/29.
//

import SwiftUI

struct StorageView: View {
    @Environment(\.dismiss) private var dismiss
    var cards: [String] = ["testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage", "testImage"]
    @State private var width: CGFloat = UIScreen.main.bounds.width - 20
    @State private var yAxis: CGFloat = 16
    @State private var counter: Int = -1
    
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
            
            ForEach(0..<cards.count) { index in
                CardStackView(index: index, card: cards[index], width: width)
                    .offset(y: yAxis + CGFloat(index * (index - 50)))
                    .animation(.easeInOut(duration: 0.6), value: yAxis)
                    .opacity(yAxis + CGFloat(index * (index - 50)) < 17 ? 1 : 0)
            }
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        if counter == 0 {
                            counter += Int(gesture.translation.height / 100)
                        } else {
                            counter += Int(gesture.translation.height / 100) / counter
                        }
                        print(counter)
                    })
            )
            .onChange(of: counter) { newValue in
                if counter < 0 {
                    yAxis += 40
                    width += 30
                } else if counter > 0 {
                    yAxis -= 40
                    width -= 30
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
    var index: Int
    var card: String
    var width: CGFloat
    
    var body: some View {
        Image(card)
            .resizable()
            .scaledToFit()
            .frame(width: width - 40 - CGFloat(index * 30))
            .zIndex(Double(10 - index))
    }
}
