//
//  ProfileView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

struct ProfileView: View {
    private let user: User?

    init(of user: User?) {
        self.user = user
    }

    var body: some View {
        HStack(alignment: .center) {
            CircleWebImage(url: user?.avatar_url ?? "", width: 50)
            VStack(alignment: .leading) {
                Text(user?.login ?? "로그인 해주세요")
                    .foregroundColor(.white)
                    .font(.body)
                    .fontWeight(.semibold)
                if user != nil {
                    Text(user?.html_url ?? "")
                        .foregroundColor(.text3)
                        .font(.subheadline)
                }
            }
            .padding(.leading, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(of: User(login: "as00098", avatar_url: "", gravatar_id: "", html_url: "https://github.HoJongPARK"))
            .previewLayout(.sizeThatFits)
            .background(Color.background1)
            .padding()
    }
}
