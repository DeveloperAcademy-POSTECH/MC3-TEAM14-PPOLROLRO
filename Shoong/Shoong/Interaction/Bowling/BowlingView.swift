//
//  BowlingView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI
import SpriteKit

struct BowlingView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var myscene: SKScene {

        let scene = BowlingGameScene()

        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .gray

        return scene

    }

    var body: some View {

        SpriteView(scene: myscene)
            .frame(width: screenWidth, height: screenHeight)
            .edgesIgnoringSafeArea(.all)

    }
}

struct BowlingView_Previews: PreviewProvider {
    static var previews: some View {
        BowlingView()
    }
}
