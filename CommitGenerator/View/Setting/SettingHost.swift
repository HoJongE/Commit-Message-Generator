//
//  SettingHost.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

struct SettingHost: View {

    @EnvironmentObject private var authentication: Authentication
    @EnvironmentObject private var bottomSheetManager: BottomSheetManager

    @State private var showingLogoutAlert: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ProfileView(of: authentication.user.value)
            Group {
                Text("태그 편집").foregroundColor(.text3)
                    .padding()
                    .font(.subheadline).frame(maxWidth: .infinity, alignment: .leading)
                Divider().background(.gray)
                NavigationLink(destination: EditTagList(title: "태그", onDelete: deleteTag(tag:))) {
                    TagSettingView("태그", image: "tag.fill", tint: .brand)
                }
                Divider().background(.gray)
                NavigationLink(destination: EditTagList(title: "기능", onDelete: deleteTag(tag:))) {
                    TagSettingView("기능", image: "square.and.pencil", tint: .orange)
                }
                Divider().background(.gray)
                ResetButton()
                Divider().background(.gray)
            }
            Group {
                Text("기타 설정").foregroundColor(.text3)
                    .padding()
                    .font(.subheadline).frame(maxWidth: .infinity, alignment: .leading)
                Divider().background(.gray)
                CloseResovledIssue()
                Divider().background(.gray)
            }
        }
        .frame(maxHeight:. infinity, alignment: .topLeading)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                LoginButton(of: authentication.user.value, onClick: onLoginButtonClick)
            }
        }
        .alert("로그아웃 하시겠습니까?", isPresented: $showingLogoutAlert) {
            Button("로그아웃", role: .destructive) {
                authentication.logout()
            }
        }
        .navigationTitle("설정")
    }

    // MARK: - 로그인 버튼 클릭 이벤트

    private func onLoginButtonClick() {
        if authentication.user.value == nil {
            bottomSheetManager.openGithubLogin()
        } else {
            showingLogoutAlert = true
        }
    }

    // MARK: - 태그 삭제 이벤트
    private func deleteTag(tag: Tag) {
        print("삭제 " + tag.description)
        PersistenceController.shared.delete(tag)
    }
}

// MARK: - 로그인 버튼
extension SettingHost {
    private struct LoginButton: View {
        private let user: User?
        private let onClick : () -> Void

        init(of user: User?, onClick :@escaping () -> Void) {
            self.user = user
            self.onClick = onClick
        }

        var body: some View {
            Button(action: {onClick()}, label: {Image(systemName: "person.circle")
                    .imageScale(.large)
                    .foregroundColor(.brand)})
        }
    }
}

struct SettingHost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingHost()
                .environmentObject(Authentication())
                .environmentObject(BottomSheetManager())
        }
        .preferredColorScheme(.dark)
    }
}
