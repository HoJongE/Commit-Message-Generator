//
//  IssuePicker.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

struct IssuePicker: View {
    
    let issueType : IssueType
    let issueAdd : (Issue) -> Void
    @EnvironmentObject private var commitViewModel : CommitWriteHost.CommitViewModel
    @EnvironmentObject private var authentication : Authentication
    @EnvironmentObject private var bottomSheetManager : BottomSheetManager
    
    var body: some View {
        VStack(alignment:.center){
            switch commitViewModel.issues {
                case .Success(data: _):
                    IssueList(issues: commitViewModel.filteredIssues ,addIssue: issueAdd)
                case .Error(error: let error):
                    ErrorView(error: error,retry: commitViewModel.getIssues(_:))
                default:
                    ProgressView()
            }
            Spacer()
        }
        .onAppear {
            commitViewModel.getIssues(1)
            if let error = authentication.user.error {
                if case NetworkError.authenticationError = error {
                    bottomSheetManager.openGithubLogin()
                }
            }
        }
        .onChange(of: authentication.user) { newValue in
            if case Lodable.Success(data: _) = newValue {
                commitViewModel.getIssues(1)
            }
        }
        .padding(.vertical)
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .navigationTitle(issueType.korTitle)
    }
}
extension IssuePicker {
    private struct ErrorView : View {
        let error : Error
        let retry : (Int) -> Void
        var body: some View {
            VStack {
                Text("이슈를 불러오는데 에러가 발생했습니다.\n\(error.localizedDescription)")
                    .foregroundColor(.error)
                    .padding()
                Button("다시 시도",action: {retry(1)})
                    .padding()
                Spacer()
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color.background1.edgesIgnoringSafeArea(.all))
            .multilineTextAlignment(.center)
        }
    }
}
struct IssuePicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IssuePicker(issueType: .Ref){_ in}
        }
        .environmentObject(CommitWriteHost.CommitViewModel())
        .environmentObject(BottomSheetManager())
        .environmentObject(Authentication())
        .preferredColorScheme(.dark)
    }
}
