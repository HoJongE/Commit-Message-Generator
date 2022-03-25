//
//  Button.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct SaveButton: View {

    let copy: (CopyType) -> Void

    var body: some View {
        Menu(content: {
            Button(action: {copy(.titleOnly)}) {
                Label("제목만 복사", systemImage: "abc")
            }
            Button(action: {copy(.bodyOnly)}) {
                Label("본문만 복사", systemImage: "list.bullet.circle")
            }
            Button(action: {copy(.all)}) {
                Label("전체 복사", systemImage: "doc.on.doc")
            }
        }) {
            Label("커밋 복사", systemImage: "arrow.up.doc.on.clipboard")
                .labelStyle(.titleAndIcon)
        }
    }
}
struct LoginButton: View {
    let onClick: () -> Void
    let loading: Bool

    var body: some View {
        Button(action: onClick) {
            if loading {
                ProgressView()
            } else {
                Text("Github로 로그인하기")
                    .font(.subheadline).fontWeight(.semibold)
                    .frame(width: 180, height: 50, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 6).fill(.white))
                    .foregroundColor(.black)
                    .padding()
            }
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
