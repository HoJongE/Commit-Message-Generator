//
//  GithubLoginView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

struct GithubLoginView: View {
    @EnvironmentObject private var authentication: Authentication
    let dismiss : () -> Void
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            GithubImage()
            Text("기능을 이용하시려면\n깃허브에 로그인 해야합니다.")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.body)
                .padding()

            LoginButton(onClick: authentication.requestCode, loading: authentication.user.loading)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .onChange(of: authentication.user) { newValue in
            if case Loadable.success(data: _) = newValue {
                dismiss()
            }
        }
    }
}

struct GithubLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GithubLoginView {}
                .environmentObject(Authentication())
        }
    }
}
