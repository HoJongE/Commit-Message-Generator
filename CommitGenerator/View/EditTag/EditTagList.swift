//
//  EditTagList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI
// MARK: - 이슈 편집 리스트
struct EditTagList: View {
    private let tags: [Tag]
    private let title: String
    private let onDelete: (Tag) -> Void
    init(tags: [Tag], title: String, onDelete : @escaping (Tag) -> Void) {
        self.tags = tags
        self.title = title
        self.onDelete = onDelete
    }

    var body: some View {
        List {
            Section(content: {
                ForEach(tags, id: \.self) { tag in
                    EditTagRow(tag: tag)
                        .listRowInsets(.init())
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        onDelete(tags[index])
                    }
                }
            }, header: {listheader})
        }
        .listStyle(.grouped)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background1)
        .navigationTitle(title)
        .toolbar(content: toolbar)
    }

    private var listheader : some View {
        HStack {
            Image(systemName: "tag.fill")
            Text(title)
        }
    }
}
// MARK: - 툴바
extension EditTagList {
    @ToolbarContentBuilder
    func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: EditTagView(tag: nil, category: title)) {
                Image(systemName: "plus").foregroundColor(.brand)
            }
        }
    }
}
// MARK: - 이슈 편집 프리뷰
struct EditTagList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditTagList(tags: [], title: "태그") { tag in
                MockedCoreData.shared.delete(tag)
            }
        }
        .preferredColorScheme(.dark)
    }
}
