//
//  Button.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct SaveButton : View {
    
    let copy : (CopyType) -> Void
    
    var body: some View {
        Menu(content: {
            Button(action : {copy(.TitleOnly)}) {
                Label("제목만 복사", systemImage: "abc")
            }
            Button(action: {copy(.BodyOnly)}) {
                Label("본문만 복사", systemImage: "list.bullet.circle")
            }
            Button(action: {copy(.All)}) {
                Label("전체 복사", systemImage: "doc.on.doc")
            }
        }) {
            Label("커밋 복사", systemImage: "arrow.up.doc.on.clipboard")
                .labelStyle(.titleAndIcon)
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SaveButton(copy: {_ in})
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
