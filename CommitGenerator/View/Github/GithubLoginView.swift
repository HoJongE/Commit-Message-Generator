//
//  GithubLoginView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

struct GithubLoginView: View {
    @EnvironmentObject var authentication : Authentication
    let dismiss : () -> Void
    var body: some View {
        Button(action: {
            authentication.requestCode()
        }){
            Text("로그인하기")
        }
        .onChange(of: authentication.user) { newValue in
            if case Lodable.Success(data: _) = newValue {
                dismiss()
            }
        }
    }
}


struct GithubLoginView_Previews: PreviewProvider {
    static var previews: some View {
        GithubLoginView{}
        .environmentObject(Authentication())
    }
}
