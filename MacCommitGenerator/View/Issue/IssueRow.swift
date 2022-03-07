//
//  IssueRow.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct IssueRow: View {
    private let issue: Issue
    @State private var showDetail: Bool = false
    
    init(_ issue: Issue) {
        self.issue = issue
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct IssueRow_Previews: PreviewProvider {
    static var previews: some View {
        IssueRow(Issue.mocIssue[0])
    }
}
