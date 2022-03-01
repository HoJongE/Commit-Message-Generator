//
//  GithubLoginView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

struct GithubLoginView: View {
    var body: some View {
        Button(action: requestCode
        ) {
            Text("깃허브 열기")
        }
        Button("이슈 겟"){
            getIssue()
        }
    }
    
    
    func requestCode() {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(Const.GitHub.CLIEND_ID)&scope=\(scope)"
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
    }
    
    func getIssue() {
        GithubService.shared.getIssues(1) { result in
            print(result.description)
        }
    }
}


struct GithubLoginView_Previews: PreviewProvider {
    static var previews: some View {
        GithubLoginView()
    }
}
