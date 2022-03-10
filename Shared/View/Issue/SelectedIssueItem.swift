//
//  IssueItem.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct IssueItem: View {
    private let issue: Issue
    private let deleteIssue: (Issue) -> Void

    init(_ issue: Issue, deleteIssue :@escaping (Issue) -> Void) {
        self.issue = issue
        self.deleteIssue = deleteIssue
    }

    var body: some View {
        Text("#\(issue.number)")
            .foregroundColor(.white)
            .frame(width: 70, height: 30, alignment: .center)
            .background(Color.brand.opacity(0.8))
            .cornerRadius(6)
            .font(.body)
            .onLongPressGesture {
                deleteIssue(issue)
            }
    }
}

struct IssuePlusButton: View {

    let issueType: IssueType
    let onIssueAdded: (Issue) -> Void

    var body: some View {

        NavigationLink(destination: IssuePicker(issueType: issueType, issueAdd: onIssueAdded)) {
            Image(systemName: "plus")
                .foregroundColor(.black)
                .frame(width: 70, height: 30, alignment: .center)
                .background(Color.white)
                .cornerRadius(6)
        }
        .buttonStyle(.plain)
    }
}

struct IssueItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IssueItem(Issue.mocIssue[0]) {_ in

            }

            IssuePlusButton(issueType: .related, onIssueAdded: {_ in })
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.background1)
    }
}
