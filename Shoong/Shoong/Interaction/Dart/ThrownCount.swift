//
//  ThrownCount.swift
//  Shoong
//
//  Created by 금가경 on 2023/08/01.
//

import SwiftUI

struct ThrownCount: View {
    let count: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 110, height: 60)
                .foregroundColor(.interactionGray)
            VStack(alignment: .leading) {
                Text("날린 사직서 갯수")
                    .font(.custom("SFPro-Regular", size: 11))
                    .foregroundColor(.interactionWhiteGray)
                Text("\(count)")
                    .font(.custom("SFPro-Semibold", size: 15))
                    .foregroundColor(.black)
            }
        }
    }
}

struct ThrownCount_Previews: PreviewProvider {
    static var previews: some View {
        ThrownCount(count: 3)
    }
}
