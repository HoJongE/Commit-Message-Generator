//
//  IssueList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

// MARK: - 선택된 이슈 리스트
struct SelectedIssueList: View {

    let issueType: IssueType
    @Binding var issues: [Issue]
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            selectedList
        }
    }
    
    private var title: some View {
        HStack {
            Text(issueType.korTitle)
                .font(.system(size: 16)).fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            Button(action: {issues.removeAll()}, label: {
                Image(systemName: "trash")
                    .foregroundColor(.brand)
                    .padding(.horizontal)
                    .padding(.vertical, 4)})
        }
    }
    
    private var selectedList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                IssuePlusButton(issueType: issueType, onIssueAdded: {issues.append($0)})
                ForEach(issues, id: \.self) {
                    IssueItem($0) { issue in
                        issues.removeAll { iter in
                            issue.number == iter.number
                        }
                    }
                }
            }
        }
    }
}
// MARK: - 이슈 리스트 프리뷰
struct IssueList_Previews: PreviewProvider {
    static var previews: some View {
        SelectedIssueList(issueType: .ref, issues: .constant(Issue.mocIssue))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.background1)
    }
}
