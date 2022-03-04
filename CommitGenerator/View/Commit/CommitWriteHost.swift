//
//  ContentView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI
import AlertToast

struct CommitWriteHost: View {

    @Environment(\.managedObjectContext) private var managedObjectContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var tags: FetchedResults<Tag>

    @EnvironmentObject private var commitViewModel: CommitViewModel

    @State private var showingResetAlert: Bool = false

    @State private var showSuccess: Bool = false
    @State private var showError: Bool = false

    private var basicTags: [Tag] {
        tags.filter { tag in
            tag.category == "태그"
        }
    }

    private var functionTags: [Tag] {
        tags.filter { tag in
            tag.category == "기능"
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("제목")
                        .font(.title2).fontWeight(.semibold)
                    HStack(spacing: 16) {
                        TagSelector(selected: $commitViewModel.selectedTag, placeholder: "태그", tags: basicTags)

                        TagSelector(selected: $commitViewModel.selectedFunction, placeholder: "기능", tags: functionTags)
                    }

                    RoundedTextField(.title, $commitViewModel.title) {
                        HStack(spacing: 16) {
                            TagSelector(selected: $commitViewModel.selectedTag, placeholder: "태그", tags: basicTags)

                            TagSelector(selected: $commitViewModel.selectedFunction, placeholder: "기능", tags: functionTags)
                        }
                    }
                }

                Divider().background(Color.white)

                Group {
                    Text("본문")
                        .font(.title2).fontWeight(.semibold)

                    RoundedTextField(.body, $commitViewModel.body) {}
                }

                Divider().background(Color.white)

                Group {
                    Text("이슈 트래커")
                        .font(.title2).fontWeight(.semibold)

                    SelectedIssueList(issueType: .resolved, issues: $commitViewModel.resolvedIssues)
                    SelectedIssueList(issueType: .fixing, issues: $commitViewModel.fixingIssues)
                    SelectedIssueList(issueType: .ref, issues: $commitViewModel.refIssues)
                    SelectedIssueList(issueType: .related, issues: $commitViewModel.relatedIssues)
                }
            }
            .padding()

        }
        .navigationTitle("커밋 작성")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                SaveButton {
                    showCopyResult(commitViewModel.copyToClipboard($0))
                }
            }

            ToolbarItem(placement: .cancellationAction) {
                ResetButton(onClick: {showingResetAlert = true})
            }
        }
        .alert("변경 내용이 초기화됩니다.", isPresented: $showingResetAlert) {
            Button("초기화", role: .destructive) {
                commitViewModel.reset()
            }
        } message: {
            Text("계속하시겠습니까?")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
        .toast(isPresenting: $showSuccess) {
            AlertToast(type: .systemImage("doc.on.clipboard.fill", .gray), title: "클립보드\n복사완료")
        }
        .toast(isPresenting: $showError) {
            AlertToast(type: .error(.error), title: "복사 실패!\n양식을 지켜주세요")
        }
    }
}

extension CommitWriteHost {
    private func showCopyResult(_ result: Bool) {
        if result {
            showSuccess = true
        } else {
            showError = true
        }
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
