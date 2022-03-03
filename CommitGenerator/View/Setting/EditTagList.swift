//
//  EditTagList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

struct EditTagList: View {
    private let title : String
    private let onDelete : (Tag) -> Void
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var tags : FetchedResults<Tag>
    
    private var filteredTag : [Tag] {
        tags.filter { tag in
            tag.category == title
        }
    }
    
    init(title : String ,onDelete : @escaping (Tag) -> Void) {
        self.title = title
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
            Section(content: {
                ForEach(filteredTag ,id: \.self) { tag in
                    EditTagRow(tag: tag)
                        .listRowInsets(.init())
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        onDelete(tags[index])
                    }
                }
            },header: {listheader})
        }
        .listStyle(.grouped)
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color.background1)
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination:EditTagView(tag: nil,category: title)){
                    Image(systemName: "plus").foregroundColor(.brand)
                }
            }
        }
    }
    
    private var listheader : some View {
        HStack {
            Image(systemName: "tag.fill")
            Text(title)
        }
    }
}

struct EditTagList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditTagList(title: "태그") { tag in
                MockedCoreData.shared.delete(tag)
            }
        }
        .preferredColorScheme(.dark)
    }
}
