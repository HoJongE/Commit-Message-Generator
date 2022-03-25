//
//  SelectedIssueList.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/09.
//

import SwiftUI

struct SelectedIssueList: View {
    let issueType: IssueType
    @Binding var issues: [Issue]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(issueType.korTitle)
                    .font(.body).fontWeight(.semibold).foregroundColor(.text3)
                Spacer()
            }
            .imageScale(.large)
            .buttonStyle(PlainButtonStyle())
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(issues, id: \.self) { current in
                        SelectedIssue(current) {
                            delete(of: current)
                        }
                    }
                }
                .padding(.bottom, 4)
            }
        }
        .padding(.init(top: 2, leading: 4, bottom: 2, trailing: 4))
        .contentShape(Rectangle())
    }
    private func delete(of issue: Issue) {
        withAnimation {
            issues.removeAll {
                $0.id == issue.id
            }
        }
    }
}
// MARK: - 선택 이슈 Column
extension SelectedIssueList {
    struct SelectedIssue: View {
        private let issue: Issue
        private let delete: () -> Void
        init(_ issue: Issue, delete: @escaping () -> Void) {
            self.issue = issue
            self.delete = delete
        }
        var body: some View {
            Text("#\(issue.number)")
                .padding(.init(top: 4, leading: 12, bottom: 4, trailing: 12))
                .background(RoundedRectangle(cornerRadius: 6)
                                .fill(Color.brand))
                .foregroundColor(.white)
                .onTapGesture(perform: delete)
        }
    }
}
// MARK: - 이슈 선택기 프리뷰
#if DEBUG
struct SelectedIssueList_Previews: PreviewProvider {
    static var previews: some View {
        SelectedIssueList(issueType: .ref, issues: .constant(Issue.mocIssue))
            .selectIndicator(sameWith: .tag, current: .tag)
    }
}
#endif
