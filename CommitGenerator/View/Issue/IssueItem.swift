//
//  IssueItem.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct IssueItem: View {
    let issue : Issue
    let color : Color
    
    init(_ issue : Issue){
        self.issue = issue
        color = Color.random
    }
    
    var body: some View {
        Text("#\(issue.issueNumber)")
            .foregroundColor(.white)
            .frame(width:70,height: 30,alignment: .center)
            .background(issue.color.opacity(0.85))
            .cornerRadius(6)
            .font(.body)
    }
}

struct IssuePlusButton : View {
    
    let issueType : IssueType
    let onIssueAdded : (Issue) -> Void
    
    var body: some View {
        
        NavigationLink(destination: IssuePicker(issueType: issueType, issueAdd: onIssueAdded)) {
            Image(systemName: "plus")
                .foregroundColor(.black)
                .frame(width: 70, height: 30, alignment: .center)
                .background(Color.white)
                .cornerRadius(6)
        }
    }
}

struct IssueItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IssueItem(Issue(58, .Fixing))
            
            IssuePlusButton(issueType: .Related ,onIssueAdded: {_ in })
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.background1)
    }
}
