//
//  IssuePicker.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

// MARK: - 이슈 선택 뷰
struct IssuePicker: View {
    let issueType: IssueType
    let issueAdd: (Issue) -> Void
    @EnvironmentObject private var commitViewModel: CommitViewModel
    @EnvironmentObject private var authentication: Authentication
    @EnvironmentObject private var bottomSheetManager: BottomSheetManager

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
        .onAppear {
            commitViewModel.getIssues(1)
            if let error = authentication.user.error {
                if case NetworkError.authenticationError = error {
                    bottomSheetManager.openGithubLogin()
                }
            }
        }
        .onChange(of: authentication.user) { newValue in
            if case Loadable.success(data: _) = newValue {
                commitViewModel.getIssues(1)
            }
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .init(horizontal: .center, vertical: .top))
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .navigationTitle(issueType.korTitle)
    }
}
// MARK: - 이슈 로딩 실패
extension IssuePicker {
    private struct ErrorView: View {
        @EnvironmentObject private var sheetManager: BottomSheetManager
        let error: Error
        let retry: (Int) -> Void
        var body: some View {
            VStack {
                Text("이슈를 불러오는데 에러가 발생했습니다.\n\(error.localizedDescription)")
                    .foregroundColor(.error)
                    .padding()
                if case NetworkError.authenticationError = error {
                    Button("깃허브 로그인", action: sheetManager.openGithubLogin)
                } else {
                    Button("다시 시도", action: {retry(1)})
                        .padding()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background1.edgesIgnoringSafeArea(.all))
            .multilineTextAlignment(.center)
        }
    }
}
// MARK: - 이슈 선택 프리뷰
struct IssuePicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IssuePicker(issueType: .ref) {_ in}
        }
        .environmentObject(CommitViewModel())
        .environmentObject(BottomSheetManager())
        .environmentObject(Authentication())
        .preferredColorScheme(.dark)
    }
}
