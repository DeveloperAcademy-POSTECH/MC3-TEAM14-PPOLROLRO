//
//  TemplateSelectViewModel.swift
//  Shoong
//
//  Created by Zerom on 2023/07/31.
//

import SwiftUI

class TemplateSelectViewModel: ObservableObject {
    @Published var templates: [[String]] = [["FixedTemplate0", "FixedTemplate1", "FixedTemplate2"],
                                            ["PartiallyEditableTemplate0", "PartiallyEditableTemplate1"],
                                            ["FullyEditableTemplate0"],
                                            [], []]
    
    @Published var isOpenArr: [Bool] = [false, true, false, false, false]
    @Published var yAxisArr: [Double] = [0, 0, UIScreen.main.bounds.height * 0.46,
                                         UIScreen.main.bounds.height * 0.6,
                                         UIScreen.main.bounds.height * 0.6]
    @Published var currentSelectedIndex: Int = 1
    @Published var selectedTemplate = ""
}
