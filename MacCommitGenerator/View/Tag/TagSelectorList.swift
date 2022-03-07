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
                        .onTapGesture {
                            tagClick(tag)
                        }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding()
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
            Text("이름")
                .font(.subheadline).foregroundColor(.text3)
            Text(tag.name ?? "")
                .foregroundColor(.white)
            Text("설명")
                .font(.subheadline).foregroundColor(.text3)
            Text(tag.tagDescription ?? "설명이 없습니다")
                .foregroundColor(.white)
        }
        
        .frame(maxWidth:.infinity, alignment: .topLeading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).fill(Color(hex: tag.colorHex ?? "123456").opacity(0.8)))
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
