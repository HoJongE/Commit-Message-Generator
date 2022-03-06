//
//  TagRow.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/06.
//

import SwiftUI

struct TagRow: View {
    @ObservedObject private var tag: Tag
    
    init(_ tag: Tag) {
        self.tag = tag
    }
    
    var body: some View {
        NavigationLink(destination: TagDetail(tag)) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(tag.name ?? "")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Circle().fill(Color(hex: tag.colorHex ?? "#123456")).frame(width: 16, height: 16, alignment: .center).padding(.horizontal, 8)
                }
                .padding(.init(top: 12, leading: 16, bottom: 4, trailing: 16))

                Text(tag.tagDescription ?? "설명 없음")
                    .foregroundColor(.text3)
                    .font(.system(size: 14))
                    .lineSpacing(4)
                    .lineLimit(2)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                Divider()
            }
        }
        .frame(height: 80)
    }
}

struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        TagRow(MockedCoreData.shared.tag())
            .previewLayout(.sizeThatFits)
    }
}
