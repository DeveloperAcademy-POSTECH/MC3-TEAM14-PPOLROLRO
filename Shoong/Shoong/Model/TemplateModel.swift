//
//  TemplateModel.swift
//  Shoong
//
//  Created by Zerom on 2023/07/27.
//

import Foundation

class TemplateModel: ObservableObject {
    @Published var templates: [[String]] = [["FixedTemplate0", "FixedTemplate1", "FixedTemplate2"],
                                            ["PartiallyEditableTemplate0", "PartiallyEditableTemplate1"],
                                            ["FullyEditableTemplate0"],
                                            [], []]
}
