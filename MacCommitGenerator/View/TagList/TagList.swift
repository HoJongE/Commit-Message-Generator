//
//  TagList.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/06.
//

import SwiftUI

struct TagList: View {
    let category: String
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: []) private var tags: FetchedResults<Tag>

    var filteredList: [Tag] {
        tags.filter { tag in
            tag.category == category
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredList, id: \.self) { tag in
                    TagRow(tag)
                        .listRowInsets(.init())
                }
            }
            .listStyle(.plain)
            .frame(width: 300)
            notSelectedView
        }
        .navigationTitle(category)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                plusButton
            }
        }
        .frame(maxWidth: .infinity)
    }

    var notSelectedView: some View {
        Label(category, systemImage: "tag.fill")
            .font(.largeTitle)
    }

    var plusButton: some View {
        Button(action: {}) {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .foregroundColor(.brand)
        }
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList(category: "태그")
            .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
    }
}
