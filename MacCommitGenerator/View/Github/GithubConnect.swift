//
//  GithubConnect.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct GithubConnect: View {
    var body: some View {
       Text("하이")
            .navigationTitle("깃허브 설정")
    }
}

struct UserInfo: View {
    let user: User
    var body: some View {
        Text("구현 예정")
    }
}

struct GithubConnect_Previews: PreviewProvider {
    static var previews: some View {
        GithubConnect()
    }
}
