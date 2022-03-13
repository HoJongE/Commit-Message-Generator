//
//  CommitWriteHost.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI
import AlertToast
// MARK: - 커밋 작성 화면
struct CommitWriteHost: View {
    @EnvironmentObject private var commitViewModel: CommitViewModel
    @State private var secondViewType: SecondView = .empty
    @State private var showSuccess: Bool = false
    @State private var showError: Bool = false
    
    enum SecondView {
        case empty
        case tag
        case function
        case resolved
        case ref
        case related
        case fixing
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Title(secondViewType: $secondViewType)
                    CommitBody()
                    IssueTracker(secondViewType: $secondViewType)
                }
                .padding()
                .frame(width: 300, alignment: .topLeading)
            }
            GeometryReader { _ in
                secondView
            }
        }
        .toolbar(content: toolbar)
        .navigationTitle("커밋 작성")
        .navigationSubtitle("쉽게 커밋을 작성해보세요")
        .toast(isPresenting: $showSuccess) {
            AlertToast(type: .systemImage("doc.on.clipboard.fill", .gray), title: "클립보드\n복사완료")
        }
        .toast(isPresenting: $showError) {
            AlertToast(type: .error(.error), title: "복사 실패!\n양식을 지켜주세요")
        }
    }
}
// MARK: - secondView
extension CommitWriteHost {
    
    @ViewBuilder
    private var secondView: some View {
        switch self.secondViewType {
        case .empty:
            EmptyView()
        case .tag:
            TagSelectorList(category: "태그") {
                commitViewModel.selectedTag = $0
            }
        case .function:
            TagSelectorList(category: "기능") {
                commitViewModel.selectedFunction = $0
            }
        case .resolved:
            IssuePicker(issueType: .resolved) {
                commitViewModel.resolvedIssues.append($0)
            }
        case .ref:
            IssuePicker(issueType: .ref) {
                commitViewModel.refIssues.append($0)
            }
        case .related:
            IssuePicker(issueType: .related) {
                commitViewModel.relatedIssues.append($0)
            }
        case .fixing:
            IssuePicker(issueType: .fixing) {
                commitViewModel.fixingIssues.append($0)
            }
        }
    }
}

// MARK: - CommitWriteHost 툴바 아이템 모음
extension CommitWriteHost {
    
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            copyButton
                .disabled(!commitViewModel.correctForm)
        }
        ToolbarItem(placement: .primaryAction) {
            resetButton
        }
    }
    
    private func showCopyResult(_ result: Bool) {
        if result {
            showSuccess = true
        } else {
            showError = true
        }
    }
    
    private var copyButton: some View {
        Menu(content: {
            Button {
                showCopyResult(commitViewModel.copyToClipboard(.titleOnly))
            } label: {
                Label("제목만 복사", systemImage: "abc")
            }
            Button {
                showCopyResult(commitViewModel.copyToClipboard(.bodyOnly))
            } label: {
                Label("본문만 복사", systemImage: "list.bullet.circle")
            }
            Button {
                showCopyResult(commitViewModel.copyToClipboard(.all))
            } label: {
                Label("전체 복사", systemImage: "doc.on.doc")
            }
        }) {
            HStack {
                Image(systemName: "arrow.up.doc.on.clipboard")
                Text("커밋 복사")
            }
        }
    }
    
    private var resetButton: some View {
        Button {
            commitViewModel.reset()
        } label: {
            HStack {
                Image(systemName: "trash.fill")
                Text("리셋")
            }
        }
    }
}
// MARK: - 제목 작성 부분
extension CommitWriteHost {
    struct Title: View {
        @EnvironmentObject private var commitViewModel: CommitViewModel
        @Binding var secondViewType: SecondView
        
        var body: some View {
            HStack {
                TagSelector(commitViewModel.selectedTag, of: "태그")
                    .onTapGesture {
                        secondViewType = .tag
                    }
                    .selectIndicator(sameWith: .tag, current: secondViewType)
                TagSelector(commitViewModel.selectedFunction, of: "기능")
                    .onTapGesture {
                        secondViewType = .function
                    }
                    .selectIndicator(sameWith: .function, current: secondViewType)
            }
            RoundedTextEditor(.title, $commitViewModel.title)
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}
// MARK: - 본문 작성 부분
struct CommitBody: View {
    @EnvironmentObject private var commitViewModel: CommitViewModel
    
    var body: some View {
        RoundedTextEditor(.body, $commitViewModel.body, 100)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
extension CommitWriteHost {
    // MARK: - 이슈 작성 부분
    struct IssueTracker: View {
        @EnvironmentObject private var commitViewModel: CommitViewModel
        @Binding var secondViewType: SecondView
        
        var body: some View {
            Group {
                SelectedIssueList(issueType: .resolved, issues: $commitViewModel.resolvedIssues)
                    .onTapGesture {
                        secondViewType = .resolved
                    }
                    .selectIndicator(sameWith: .resolved, current: secondViewType)
                SelectedIssueList(issueType: .ref, issues: $commitViewModel.refIssues)
                    .onTapGesture {
                        secondViewType = .ref
                    }
                    .selectIndicator(sameWith: .ref, current: secondViewType)
                SelectedIssueList(issueType: .related, issues: $commitViewModel.relatedIssues)
                    .onTapGesture {
                        secondViewType = .related
                    }
                    .selectIndicator(sameWith: .related, current: secondViewType)
                SelectedIssueList(issueType: .fixing, issues: $commitViewModel.fixingIssues)
                    .onTapGesture {
                        secondViewType = .fixing
                    }
                    .selectIndicator(sameWith: .fixing, current: secondViewType)
                
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}

struct CommitWriteHost_Previews: PreviewProvider {
    static var previews: some View {
        CommitWriteHost()
            .environmentObject(CommitViewModel())
    }
}
