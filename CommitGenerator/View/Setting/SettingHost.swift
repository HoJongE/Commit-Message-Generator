//
//  SettingHost.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

struct SettingHost: View {
    
    @EnvironmentObject private var authentication : Authentication
    @EnvironmentObject private var bottomSheetManager : BottomSheetManager
    
    @State private var showingLogoutAlert : Bool = false
    
    var body: some View {
        VStack(spacing:0) {
            ProfileView(of: authentication.user.value)
            Group {
                Divider().background(.gray).padding(.top)
                TagSettingView("태그", image: "tag.fill", tint: .brand)
                Divider().background(.gray)
                TagSettingView("기능", image: "square.and.pencil", tint: .orange)
                Divider().background(.gray)
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                LoginButton(of: authentication.user.value, onClick: onLoginButtonClick)
            }
        }
        .alert("로그아웃 하시겠습니까?", isPresented: $showingLogoutAlert) {
            Button("로그아웃" , role: .destructive) {
                authentication.logout()
            }
        }
        .navigationTitle("설정")
    }
    
    
    private func onLoginButtonClick() {
        if authentication.user.value == nil {
            bottomSheetManager.openGithubLogin()
        } else {
            showingLogoutAlert = true
        }
    }
}

extension SettingHost {
    private struct LoginButton : View {
        private let user : User?
        private let onClick : () -> Void
        
        init(of user : User?,onClick :@escaping () -> Void) {
            self.user = user
            self.onClick = onClick
        }
        
        var body: some View {
            Button(action:{onClick()}){
                Image(systemName: "person.circle")
                    .imageScale(.large)
                    .foregroundColor(.brand)
            }
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
