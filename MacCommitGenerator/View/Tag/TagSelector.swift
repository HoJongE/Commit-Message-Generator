//
//  TagSelector.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct TagSelector: View {
    
    private var selected: Tag?
    let category: String
    
    init(_ selected: Tag?, of category: String) {
        self.selected = selected
        self.category = category
    }
    
    var body: some View {
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
        .frame(height: 24)
        .background(RoundedRectangle(cornerRadius: 6).fill(Color(hex: selected?.colorHex ?? "888888")).shadow(radius: 1))
        .buttonStyle(.link)
    }
}

struct TagSelector_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagSelector(nil, of: "태그")
                .preferredColorScheme(.dark)
            TagSelector(nil, of: "태그")
                .preferredColorScheme(.light)
        }
        .padding()
    }
}
