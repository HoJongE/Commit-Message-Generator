//
//  TagSelectorList.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct TagSelectorList: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) private var tags: FetchedResults<Tag>

    let category: String
    let tagClick: (Tag) -> Void
    
    private var filteredList: [Tag] {
        tags.filter { tag in
            tag.category == category
        }
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(filteredList, id: \.self) { tag in
                    TagSelectorRow(tag)
                        .listRowInsets(.init())
                        .onTapGesture {
                            withAnimation {
                                tagClick(tag)
                            }
                        }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Tag Selector Row
struct TagSelectorRow: View {
    private let tag: Tag

    init(_ tag: Tag) {
        self.tag = tag
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(tag.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                Circle().fill(Color(hex: tag.colorHex ?? "#123456")).frame(width: 16, height: 16, alignment: .center).padding(.horizontal, 8)
            }
            .padding(.init(top: 12, leading: 16, bottom: 4, trailing: 16))

            Text(tag.tagDescription ?? "설명 없음")
                .foregroundColor(.text3)
                .font(.system(size: 14))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.init(top: 4, leading: 16, bottom: 12, trailing: 16))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            Divider()
        }
        .contentShape(Rectangle())
    }
}
struct TagSelectorList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagSelectorList(category: "태그") {_ in}
                .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
            TagSelectorRow(MockedCoreData.shared.tag())
        }
        .padding()
    }
}
