//
//  ContentView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags : FetchedResults<Tag>
    
    @State var title : String = ""
    
    var basicTags : [Tag] {
        tags.filter { tag in
            tag.category == "태그"
        }
    }
    
    var functionTags : [Tag] {
        tags.filter { tag in
            tag.category == "기능"
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment:.leading,spacing: 16) {
                
                Text("제목")
                    .font(.title2).fontWeight(.semibold)
                HStack(spacing:16){
                    TagSelector(placeholder: "태그", tags: basicTags, onTagSelected: {_ in
                        
                    })
                    
                    TagSelector(placeholder: "기능", tags: functionTags, onTagSelected: {_ in})
                }
                
                RoundedTextField(placeholder: "제목", text: $title)
                
                Spacer()
                
                CopyButton()
            }
            .padding()
        }
        .navigationTitle("커밋 작성")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                SettingButton {
                    Text("설정")
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity,alignment: .topLeading)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
        }
    }
}
