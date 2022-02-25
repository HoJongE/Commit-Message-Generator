//
//  TagList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct TagList: View {
    @Environment(\.dismiss) private var dismiss
    let placeholder : String
    var selected : Binding<Tag?>
    let tags : [Tag]
    let onTagSelected : (Tag) -> Void
    
    init(_ placeholder : String ,_ selected : Binding<Tag?>, _ tags : [Tag], onTagSelected : @escaping (Tag) -> Void){
        self.placeholder  = placeholder
        self.selected = selected
        self.tags = tags
        self.onTagSelected = onTagSelected
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            ForEach(tags,id: \.self) { tag in
                Button(action:{
                    dismiss()
                    selected.wrappedValue = tag
                    onTagSelected(tag)
                }){
                    TagRow(tag: tag, selected: selected.wrappedValue != nil &&
                           selected.wrappedValue! == tag)
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
            TagList("기능",.constant(Tag.provideDummyTags()[0]),Tag.provideDummyTags()){ _ in
                
            }
        }
    }
}