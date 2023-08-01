//
//  SlingShotView.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

import SwiftUI
import UIKit
import SpriteKit

struct SlingShotGameScene: View {

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //네
    var myscene: SKScene {

        let scene = SlingShotViewModel() //GameScene.swift의 class

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

struct SlingShotGameScene_Previews: PreviewProvider {
    static var previews: some View {
        SlingShotGameScene()
    }
}
