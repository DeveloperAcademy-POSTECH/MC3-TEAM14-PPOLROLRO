//
//  DirTestView1.swift
//  Shoong
//
//  Created by Sup on 2023/07/27.
//

// Template에 글자를 위한 model

import SwiftUI

struct TextBoxModel: Identifiable {
    var id = UUID().uuidString
    var text: String = ""
    var textColor: Color = .black
}
