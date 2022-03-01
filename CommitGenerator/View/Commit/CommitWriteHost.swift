//
//  ContentView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct CommitWriteHost: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags : FetchedResults<Tag>
    
    @EnvironmentObject var commitViewModel : CommitViewModel
    
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
                Group {
                    Text("제목")
                        .font(.title2).fontWeight(.semibold)
                    HStack(spacing:16){
                        TagSelector(selected: $commitViewModel.selectedTag,placeholder: "태그", tags: basicTags)
                        
                        TagSelector(selected: $commitViewModel.selectedFunction,placeholder: "기능", tags: functionTags)
                    }
                    
                    RoundedTextField(.Title , $commitViewModel.title){
                        HStack(spacing:16){
                            TagSelector(selected: $commitViewModel.selectedTag,placeholder: "태그", tags: basicTags)
                            
                            TagSelector(selected: $commitViewModel.selectedFunction,placeholder: "기능", tags: functionTags)
                        }
                    }
                }
                
                Divider().background(Color.white)
                
                Group {
                    Text("본문")
                        .font(.title2).fontWeight(.semibold)
                    
                    RoundedTextField(.Body, $commitViewModel.body){}
                }
                
                Divider().background(Color.white)
                
                Group {
                    Text("이슈 트래커")
                        .font(.title2).fontWeight(.semibold)
                    
                    IssueList(issueType:.Resolved, issues: $commitViewModel.resolvedIssues)
                    IssueList(issueType : .Fixing , issues: $commitViewModel.fixingIssues)
                    IssueList(issueType : .Ref, issues: $commitViewModel.refIssues)
                    IssueList(issueType:.Related, issues: $commitViewModel.relatedIssues)
                }
            }
            .padding()
            
        }
        .navigationTitle("커밋 작성")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                SaveButton(copy: commitViewModel.copyToClipboard(_:))
            }
            
            ToolbarItem(placement: .cancellationAction) {
                ResetButton(onClick: commitViewModel.reset)
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
            CommitWriteHost()
                .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
                .environmentObject(CommitWriteHost.CommitViewModel())
        }
    }
}
