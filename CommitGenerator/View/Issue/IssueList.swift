//
//  IssueList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct IssueList: View {
    
    let issueType : IssueType
    let issues : [Issue]
    let onIssueAdded : (Issue) -> Void
    
    var body: some View {
        VStack(alignment:.leading) {
            
            Text(issueType.rawValue)
                .font(.system(size: 16)).fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:16) {
                    IssuePlusButton(issueType: issueType, onIssueAdded: onIssueAdded)
                    ForEach(issues, id: \.self) {
                        IssueItem($0)
                    }
                }
            }
        }
    }
}

struct IssueList_Previews: PreviewProvider {
    static var previews: some View {
        IssueList(issueType: .Ref ,issues: Issue.mocIssue, onIssueAdded: {_ in })
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.background1)
    }
}
