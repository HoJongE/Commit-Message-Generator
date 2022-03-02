//
//  ContentView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct CommitWriteHost: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var tags : FetchedResults<Tag>
    
    @EnvironmentObject private var commitViewModel : CommitViewModel
    
    @State private var showingResetAlert : Bool = false
        
    private var basicTags : [Tag] {
        tags.filter { tag in
            tag.category == "태그"
        }
    }
    
    private var functionTags : [Tag] {
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
                    
                    SelectedIssueList(issueType:.Resolved, issues: $commitViewModel.resolvedIssues)
                    SelectedIssueList(issueType : .Fixing , issues: $commitViewModel.fixingIssues)
                    SelectedIssueList(issueType : .Ref, issues: $commitViewModel.refIssues)
                    SelectedIssueList(issueType:.Related, issues: $commitViewModel.relatedIssues)
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
                ResetButton(onClick: {showingResetAlert = true})
            }
        }
        .alert("변경 내용이 초기화됩니다.", isPresented: $showingResetAlert) {
            Button("초기화" , role: .destructive) {
                commitViewModel.reset()
            }
        } message: {
            Text("계속하시겠습니까?")
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
