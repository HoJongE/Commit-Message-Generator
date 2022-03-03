//
//  IssueList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct SelectedIssueList: View {

    let issueType: IssueType
    @Binding var issues: [Issue]

    var body: some View {
        VStack(alignment: .leading) {
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
}

struct IssueList_Previews: PreviewProvider {
    static var previews: some View {
        SelectedIssueList(issueType: .ref, issues: .constant(Issue.mocIssue))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.background1)
    }
}
