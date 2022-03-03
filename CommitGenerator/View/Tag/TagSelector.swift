//
//  TagSelector.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct TagSelector: View {
    @Binding var selected: Tag?
    let placeholder: String
    let tags: [Tag]

    var body: some View {
        NavigationLink(destination: TagList(placeholder, $selected, tags)) {
            HStack(spacing: 0) {
                Text(selected?.name ?? placeholder)
                    .font(.body)
                    .padding()
                Divider()
                    .background(Color.gray)
                Image(systemName: "arrow.right")
                    .imageScale(.small)
                    .padding(8)

            }
            .foregroundColor(selected == nil ? .black : .white)
        }
        .frame(height: 30)
        .background(RoundedRectangle(cornerRadius: 6).fill(selected == nil ? .white : Color(hex: selected!.colorHex ?? "123456")))
    }
}

struct TagSelector_Previews: PreviewProvider {
    static var previews: some View {
        TagSelector(selected: .constant(nil), placeholder: "기능", tags: MockedCoreData.shared.tags())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black)
    }
}
