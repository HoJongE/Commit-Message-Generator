//
//  CommitWriteHost.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI
// MARK: - 커밋 작성 화면
struct CommitWriteHost: View {
    @EnvironmentObject private var commitViewModel: CommitViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Title()
                    CommitBody()
                    IssueTracker()
                }
                .padding()
                .frame(width: 300, alignment: .topLeading)
            }
        }
        .toolbar(content: {Toolbar()})
        .navigationTitle("커밋 작성")
    }
}
// MARK: - CommitWriteHost 툴바 아이템 모음
extension CommitWriteHost {
    
    struct Toolbar: ToolbarContent {
        var body: some ToolbarContent {
            ToolbarItem(placement: .automatic) {
                copyButton
            }
            ToolbarItem(placement: .automatic) {
                resetButton
            }
        }
        
        var copyButton: some View {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "arrow.up.doc.on.clipboard")
                    Text("커밋 복사")
                }
            }
        }
        
        var resetButton: some View {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("리셋")
                }
            }
        }
    }
}

// MARK: - 제목 작성 부분
struct Title: View {
    @EnvironmentObject private var commitViewModel: CommitViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("제목")
                .font(.title2).fontWeight(.semibold)
            HStack {
                TagSelector($commitViewModel.selectedTag, of: "태그")
                TagSelector($commitViewModel.selectedFunction, of: "기능")
            }
            RoundedTextEditor(.title, $commitViewModel.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
// MARK: - 본문 작성 부분
struct CommitBody: View {
    @EnvironmentObject private var commitViewModel: CommitViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("본문")
                .font(.title2).fontWeight(.semibold)
            RoundedTextEditor(.body, $commitViewModel.body, 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
// MARK: - 이슈 작성 부분
struct IssueTracker: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("이슈")
                .font(.title2).fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CommitWriteHost_Previews: PreviewProvider {
    static var previews: some View {
        CommitWriteHost()
            .environmentObject(CommitViewModel())
    }
}
