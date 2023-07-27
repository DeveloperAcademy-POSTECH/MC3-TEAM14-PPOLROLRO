//
//  TestNaviView.swift
//  Shoong
//
//  Created by Zerom on 2023/07/28.
//

import SwiftUI

struct TestNaviView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    TemplateCrumpleView1()
                } label: {
                    Text("gogo")
                        .font(.largeTitle)
                }

            }
        }
    }
}

struct TestNaviView_Previews: PreviewProvider {
    static var previews: some View {
        TestNaviView()
    }
}
