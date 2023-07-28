//
//  ToggleStyle.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct MyToggleStyle: ToggleStyle {
    private let width = 38.0
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: width, height: width / 2)
                    .foregroundColor(configuration.isOn ? .black : .gray)
                
                Circle()
                    .frame(width: (width / 2) - 3)
                    .padding(2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
            }
        }
    }
}
