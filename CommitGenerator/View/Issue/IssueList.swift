//
//  IssueList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct IssueList: View {
    
    let issueType : IssueType
    @Binding var issues : [Issue]
    
    var body: some View {
        VStack(alignment:.leading) {
            
            Text(issueType.korTitle)
                .font(.system(size: 16)).fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:16) {
                    IssuePlusButton(issueType: issueType, onIssueAdded: {issues.append($0)})
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
        IssueList(issueType: .Ref ,issues: .constant(Issue.mocIssue))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.background1)
    }
}
