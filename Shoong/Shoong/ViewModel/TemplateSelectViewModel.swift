//
//  TemplateSelectViewModel.swift
//  Shoong
//
//  Created by Zerom on 2023/07/31.
//

import Foundation

class TemplateSelectViewModel: ObservableObject {
    @Published var templates: [[String]] = [["FixedTemplate0", "FixedTemplate1", "FixedTemplate2"],
                                            ["PartiallyEditableTemplate0", "PartiallyEditableTemplate1"],
                                            ["FullyEditableTemplate0"],
                                            [], []]
    @Published var selectedTemplates: String = ""
}
