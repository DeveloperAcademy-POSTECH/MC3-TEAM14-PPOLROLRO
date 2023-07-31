//
//  ContentView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                StorageView()
            } label: {
                Text("gogo")
                    .font(.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
