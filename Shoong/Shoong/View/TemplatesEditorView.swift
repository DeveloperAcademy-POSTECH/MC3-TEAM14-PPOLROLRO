//
//  TemplatesEditorView.swift
//  Shoong
//
//  Created by Sup on 2023/07/28.
//

import SwiftUI

struct TemplatesEditorView: View {

    @EnvironmentObject var model: TemplatesEditorViewModel

    var body: some View {

        ZStack{
            // textBoxes에 있는 글자들 1개씩 Box로 꺼내서 화면에 표시
            ForEach(model.textBoxes) { Box in
                TextDragGesture(textBox: Box)
                .shadow(color: .black, radius: 5,x: 1,y: 1)}
        }
    }
}


struct TemplatesEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TemplatesEditorView()
            .environmentObject(TemplatesEditorViewModel())
    }
}
