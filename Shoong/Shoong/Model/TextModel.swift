//
//  TextModel.swift
//  TestTemplateEdit
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

struct TextModel: Hashable {
    var id: String = UUID().uuidString
    var text: String
    var xAxis: CGFloat
    var yAxis: CGFloat
    var color: Color
    var fontSize: CGFloat
}
