//
//  TagSelector.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct TagSelector: View {
    @State private var selected : Tag? = nil 
    let placeholder : String
    let tags : [Tag]
    
    let onTagSelected : (Tag) -> Void
    
    var body: some View {
        NavigationLink(destination: TagList(placeholder, $selected, tags, onTagSelected: onTagSelected)) {
            HStack(spacing:0) {
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
        .background(RoundedRectangle(cornerRadius: 6).fill(selected == nil ? .white : Color(hex: selected!.colorHex)))
    }
}

struct TagSelector_Previews: PreviewProvider {
    static var previews: some View {
        TagSelector(placeholder: "기능", tags: Tag.provideDummyTags()){_ in }
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black)
    }
}
