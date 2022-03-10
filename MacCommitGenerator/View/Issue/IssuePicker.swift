//
//  IssuePicker.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/09.
//

import SwiftUI

struct IssuePicker: View {
    let issueType: IssueType
    let issueAdd: (Issue) -> Void
    @EnvironmentObject private var commitViewModel: CommitViewModel
    @EnvironmentObject private var authentication: Authentication
    
    var body: some View {
        VStack(alignment: .center) {
            switch commitViewModel.issues {
            case .success(data: _):
                IssueList(issues: commitViewModel.filteredIssues, addIssue: issueAdd)
            case .error(error: let error):
                ErrorView(error: error, retry: commitViewModel.getIssues(_:))
            default:
                ProgressView()
            }
        }
        .frame(maxWidth:.infinity, alignment: .init(horizontal: .center, vertical: .top))
        .onAppear {
            commitViewModel.getIssues(1)
        }
    }
}

extension IssuePicker {
    struct ErrorView: View {
        let error: Error
        let retry: (Int) -> Void
        
        var body: some View {
            VStack {
                Text(error.localizedDescription)
                    .foregroundColor(.error)
                Button(action: {retry(1)}) {
                    Text("다시 시도")
                }
            }
        }
    }
}

struct IssuePicker_Previews: PreviewProvider {
    static var previews: some View {
        IssuePicker(issueType: .fixing, issueAdd: {_ in})
            .environmentObject(CommitViewModel())
            .environmentObject(Authentication())
    }
}
