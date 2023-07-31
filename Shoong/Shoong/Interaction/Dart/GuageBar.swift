//
//  GuageBar.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/01.
//

import SwiftUI

struct GuageBar: View {
    var body: some View {
        let randomGuage = CGFloat.random(in: 0...330)
        
        ZStack() {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 42, height: 358)
                .foregroundColor(.green)
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 7, height: 330)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 7, height: randomGuage)
                    .foregroundColor(.red)
            }
        }
    }
}

struct GuageBar_Previews: PreviewProvider {
    static var previews: some View {
        GuageBar()
    }
}
