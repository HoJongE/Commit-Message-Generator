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
                Button(action: removeAll) {
                    Image(systemName: "trash")
                        .foregroundColor(.brand)
                }
            }
            .imageScale(.large)
            .buttonStyle(PlainButtonStyle())
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(issues, id: \.self) {
                        SelectedIssue($0)
                    }
                }
                .padding(.bottom,4)
            }
        }
        .padding(.init(top: 2, leading: 4, bottom: 2, trailing: 4))
        .contentShape(Rectangle())
    }
    
    private func removeAll() {
        withAnimation {
            issues.removeAll()
        }
    }
}
// MARK: - 선택 이슈 Column
extension SelectedIssueList {
    struct SelectedIssue: View {
        private let issue: Issue
        init(_ issue: Issue) {
            self.issue = issue
        }
        var body: some View {
            Text("#\(issue.number)")
                .padding(.init(top: 4, leading: 12, bottom: 4, trailing: 12))
                .background(RoundedRectangle(cornerRadius: 6)
                                .fill(Color.brand))
                .foregroundColor(.white)
        }
    }
}
// MARK: - 이슈 선택기 프리뷰
struct SelectedIssueList_Previews: PreviewProvider {
    static var previews: some View {
        SelectedIssueList(issueType: .ref, issues: .constant(Issue.mocIssues))
            .selectIndicator(sameWith: .tag, current: .tag)
    }
}
