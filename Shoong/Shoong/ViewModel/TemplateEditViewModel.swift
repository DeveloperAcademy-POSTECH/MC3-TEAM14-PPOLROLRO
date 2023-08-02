//
//  TemplateEditViewModel.swift
//  TestTemplateEdit
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

class TemplateEditViewModel: ObservableObject {
    @Published var textModels: [TextModel] = []
    @Published var selectColor: Color = .black
    @Published var selectIndex: Int = 100
    
    func changeTextModelAxis(index: Int, xAxis: CGFloat, yAxis: CGFloat) {
        textModels[index] = TextModel(text: textModels[index].text, xAxis: xAxis, yAxis: yAxis, color: textModels[index].color, fontSize: textModels[index].fontSize)
    }
}
