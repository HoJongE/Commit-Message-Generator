//
//  TagSelector.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct TagSelector: View {
    
    @Binding private var selected: Tag?
    let category: String
    
    init(_ selected: Binding<Tag?>, of category: String) {
        self._selected = selected
        self.category = category
    }
    
    var body: some View {
        NavigationLink(destination: TagSelectorList(category: category, tagClick: tagClick(tag:))) {
            HStack(alignment: .center, spacing: 0) {
                Text(selected?.name ?? category)
                    .font(.body).fontWeight(.semibold)
                    .padding(.horizontal, 12)
                Divider()
                    .background(Color.white)
                Image(systemName: "arrow.right")
                    .padding(.horizontal, 8)
            }
            .foregroundColor(.white)
            .frame(height:24)
            .background(RoundedRectangle(cornerRadius: 6).fill(Color(hex: selected?.colorHex ?? "888888")).shadow(radius: 1))
        }
        .buttonStyle(.link)
    }
    
    private func tagClick(tag: Tag) -> Void {
        withAnimation(.easeInOut) {
            selected = tag
        }
    }
}

struct TagSelector_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagSelector(.constant(nil), of: "태그")
                .preferredColorScheme(.dark)
            TagSelector(.constant(nil), of: "태그")
                .preferredColorScheme(.light)
        }
        .padding()
    }
}
