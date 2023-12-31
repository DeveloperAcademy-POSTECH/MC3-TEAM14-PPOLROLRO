//
//  InteractionCardView.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct InteractionCardView: View {
    var width: CGFloat
    var interactionName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.interactionCardBeige)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("마지막으로 날린 속도")
                            .font(.custom("SFPro-Bold", size: 15))
                            .foregroundColor(.fontOrange)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.backGroundBeige)
                                .frame(width: 144, height: 8)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.fontOrange)
                                .frame(width: 70, height: 8)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.forward")
                        .font(.system(size: 24))
                }
                
                HStack {
                    Text(interactionName)
                        .font(.custom("SFPro-Bold", size: 24))
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("날린 사직서 갯수")
                        .font(.custom("SFPro-Regular", size: 13))
                    
                    Text("045")
                        .font(.custom("SFPro-Semibold", size: 17))
                }
                .opacity(0.7)
            }
            .padding(20)
            .foregroundColor(.black)
        }
        .frame(width: width - 32, height: 170)
    }
}

struct InteractionCardView_Previews: PreviewProvider {
    static var previews: some View {
        InteractionCardView(width: UIScreen.main.bounds.width, interactionName: "Hi")
    }
}
