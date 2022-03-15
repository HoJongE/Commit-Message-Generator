//
//  TagList.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/06.
//

import SwiftUI

struct TagList: View {
    let tags: [Tag]
    let category: String

    var body: some View {
        NavigationView {
            List {
                ForEach(tags, id: \.self) { tag in
                    TagRow(tag)
                        .listRowInsets(.init())
                }
            }
            .listStyle(.plain)
            .frame(width: 300, alignment: .topLeading)
            notSelectedView
        }
        .navigationTitle(category)
        .navigationSubtitle("\(category)를 편집합니다")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                plusButton
            }
        }
        .frame(maxWidth: .infinity)
    }

    var notSelectedView: some View {
        Label(category, systemImage: "tag.fill")
            .font(.largeTitle)
    }

    var plusButton: some View {
        Button(action: {
            Window.addTagView.open()
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("태그 추가")
            }
        }
    }
}
#if DEBUG
struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagList(tags: [], category: "태그")
                .preferredColorScheme(.dark)
            TagList(tags: [], category: "태그")
                .preferredColorScheme(.light)
        }
    }
}
#endif
