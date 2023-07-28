//
//  TemplateCrumpleScriptView.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TemplateCrumpleScriptView: View {
    var width: CGFloat
    var viewIndex: Int
    var scriptArr: [String] = ["끝없는 회사일로 지친 당신은 오늘\n드디어, 사직서를 휘갈겨쓴 채로 봉투에 담았다!"]
    
    var body: some View {
        ZStack {
            Image("crumpleFolder")
                .resizable()
                .scaledToFit()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("건너뛰기")
                        .padding(.trailing, 10)
                }
                .padding(.bottom, 10)
                
            }
        }
        .frame(width: width, height: width * 162.5 / 358)
    }
}

struct TemplateCrumpleScriptView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateCrumpleScriptView(width: UIScreen.main.bounds.width, viewIndex: 0)
    }
}
