//
//  TagList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct TagList: View {
    @Environment(\.dismiss) private var dismiss
    private let placeholder : String
    private let tags : [Tag]
    
    @Binding private var selected : Tag?

    init(_ placeholder : String ,_ selected : Binding<Tag?>, _ tags : [Tag]){
        self.placeholder  = placeholder
        self._selected = selected
        self.tags = tags
    }

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true){
            ForEach(tags,id: \.self) { tag in
                Button(action:{
                    dismiss()
                    selected = tag
                }){
                    TagRow(tag: tag, selected: selected != nil &&
                           selected! == tag)
                        .padding(.horizontal)
                        .padding(.vertical,4)
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .leading)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .navigationTitle("\(placeholder) 선택")
        .preferredColorScheme(.dark)
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TagList("기능",.constant(MockedCoreData.shared.tag()),MockedCoreData.shared.tags())
        }
    }
}
