//
//  GithubProfile.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct GithubConnect: View {
    @EnvironmentObject private var authentication: Authentication
    
    var body: some View {
        switch authentication.user {
        case .empty, .loading, .error(error: _):
            EmptyUser()
                .navigationTitle("깃허브 계정 연동")
        case .success(data: let user):
            GithubProfile(user: user, logout: authentication.logout)
                .navigationTitle("깃허브 계정 연동")
        }
    }
}
// MARK: - 깃허브 인증 완료 뷰
extension GithubConnect {
    struct GithubProfile: View {
        let user: User
        let logout: () -> Void
        var body: some View {
            HStack(alignment: .center) {
                CircleWebImage(url: user.avatar_url, width: 50)
                VStack(alignment: .leading) {
                    Text(user.login)
                    Text(user.html_url)
                        .foregroundColor(.text3)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: logout) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                            Text("로그아웃")
                        }
                    }
                }
            }
        }
    }
}
// MARK: 깃허브 인증 X 뷰
extension GithubConnect {
    struct EmptyUser: View {
        @EnvironmentObject private var authentication: Authentication
        @State private var showCode: Bool = false
        
        var body: some View {
            VStack(spacing: 16) {
                GithubImage()
                Text("이슈를 불러오기 위해선\n깃허브에 연결해야 합니다.")
                    .multilineTextAlignment(.center)
                Button(action: requestCode) {
                    Text("깃허브 계정 연결하기")
                }
            }
            .navigationTitle("깃허브 설정")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onChange(of: authentication.deviceflowResult) {
                if case Lodable.success(data: _) = $0 {
                    showCode = true
                }
            }
            .sheet(isPresented: $showCode, onDismiss: {authentication.deviceflowResult = Lodable.empty}) {
                VerificationCode()
            }
        }
        
        private func requestCode() {
            authentication.deviceflow()
        }
    }
}
// MARK: - 깃허브 인증 프리뷰
struct GithubProfile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GithubConnect.EmptyUser()
                .padding()
        }
        .environmentObject(Authentication())
    }
}
