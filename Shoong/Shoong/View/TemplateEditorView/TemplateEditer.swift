//
//  TemplateEditer.swift
//  TestTemplateEdit
//
//  Created by Zerom on 2023/08/02.
//

import SwiftUI

struct TemplateEditer: View {
    @EnvironmentObject var templateEditViewModel: TemplateEditViewModel
    
    @State private var position = CGSize.zero
    @State private var draggedOffset: CGSize = CGSize(width: 0, height: -64)
    @State private var accumulatedOffset: CGSize = CGSize(width: 0, height: -64)
    
    let width: CGFloat = UIScreen.main.bounds.width - 12
    let height: CGFloat = (UIScreen.main.bounds.width - 12) * 464 / 348
    
    var body: some View {
        ZStack {
            Image("template4")
                .resizable()
                .scaledToFit()
            
            ForEach(0..<templateEditViewModel.textModels.count, id: \.self) { index in
                Text(templateEditViewModel.textModels[index].text)
                    .font(.system(size: templateEditViewModel.textModels[index].fontSize))
                    .foregroundColor(templateEditViewModel.textModels[index].color)
                    .offset(x: max(-width / 2 + 30, min(width / 2 - 30, index == templateEditViewModel.selectIndex ? draggedOffset.width : templateEditViewModel.textModels[index].xAxis)), y: max(-height / 2 + 10, min(height / 2 - 10, index == templateEditViewModel.selectIndex ? draggedOffset.height : templateEditViewModel.textModels[index].yAxis)))
                    .gesture(
                        DragGesture()
                                .onChanged { newValue in
                                    templateEditViewModel.selectIndex = index
                                    
                                    draggedOffset = CGSize(width: templateEditViewModel.textModels[index].xAxis, height: templateEditViewModel.textModels[index].yAxis)
                                    accumulatedOffset = CGSize(width: templateEditViewModel.textModels[index].xAxis, height: templateEditViewModel.textModels[index].yAxis)
                                    
                                    draggedOffset.width = accumulatedOffset.width + newValue.translation.width
                                    draggedOffset.height = accumulatedOffset.height + newValue.translation.height
                                }
                                .onEnded({ newValue in
                                    accumulatedOffset.width = max(-width / 2 + 30, min(width / 2 - 30, accumulatedOffset.width + newValue.translation.width))
                                    accumulatedOffset.height = max(-height / 2 + 10, min(height / 2 - 10, accumulatedOffset.height + newValue.translation.height))
                                    
                                    templateEditViewModel.changeTextModelAxis(index: index, xAxis: draggedOffset.width, yAxis: draggedOffset.height)
                                    
                                    templateEditViewModel.selectIndex = 100
                            }))
            }
        }
        .frame(width: width, height: height)
    }
}

struct TemplateEditer_Previews: PreviewProvider {
    static var previews: some View {
        TemplateEditer()
    }
}
