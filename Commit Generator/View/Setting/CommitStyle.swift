//
//  CommitStyle.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/13.
//

import SwiftUI

struct CommitStyleGuide: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Udacity Git Commit Message Style Guide")
                .underline()
                .font(.body)
                .bold() + Text("를 따릅니다.\n세부적인 태그와 기능 수정은 편집해서 사용할 수 있습니다.")
            
            Text("""
type(옵션):[#issueNumber]Subject //-> 제목
개행
body(옵션):// ->본문
개행
footer(옵션)://-> 꼬리말
""")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 6)
                                .fill(Color.background2))
                
            if let url = URL(string: "https://udacity.github.io/git-styleguide/") {
                Link(destination: url) {
                    Text("Udacity 스타일 가이드 바로가기")
                }
                .padding(8)
                .contentShape(Rectangle())
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("커밋 스타일")
    }
}

struct CommitStyle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommitStyleGuide()
        }
        .preferredColorScheme(.dark)
    }
}
