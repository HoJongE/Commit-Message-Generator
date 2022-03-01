//
//  GithubLoginView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

struct GithubLoginView: View {
    @EnvironmentObject private var authentication : Authentication
    let dismiss : () -> Void
    var body: some View {
        VStack(alignment:.center, spacing:16) {
            GithubImage()
            Text("기능을 이용하시려면\n깃허브에 로그인 해야합니다.")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.body)
                .padding()
            
            LoginButton(onClick: authentication.requestCode,loading: authentication.user.loading)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .onChange(of: authentication.user) { newValue in
            if case Lodable.Success(data: _) = newValue {
                dismiss()
            }
        }
    }
}

extension GithubLoginView {
    
    private struct LoginButton : View {
        let onClick : () -> Void
        let loading : Bool
        
        var body: some View {
            Button(action:onClick) {
                if loading {
                    ProgressView()
                } else {
                    Text("Github로 로그인하기")
                        .font(.subheadline).fontWeight(.semibold)
                        .frame(width: 180, height: 50, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 6).fill(.white))
                        .foregroundColor(.black)
                        .padding()
                }
            }
        }
    }
}

struct GithubLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GithubLoginView{}
                .environmentObject(Authentication())
        }
    }
}
