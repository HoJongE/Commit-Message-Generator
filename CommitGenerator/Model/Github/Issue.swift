//
//  Issue.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import SwiftUI

struct Issue: Codable, Hashable {
    let id: Int
    let title: String
    let number: Int
    let body: String?
    let repository_url: String
    let user: User

}

extension Issue: CustomStringConvertible {
    var description: String {
        "Issue Number:\(number) Issue Title:\(title) maker:\(user.login)"
    }
}

extension Issue {
    static var mocIssues: [Issue] {
        [Issue(id: 12, title: "로그인 API 구현", number: 12, body: nil, repository_url: "/Commit Generator", user: User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: "")),Issue(id: 12, title: "코드리뷰", number: 13, body: nil, repository_url: "/Commit Generator", user: User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: "")),
         Issue(id: 12, title: "로그인 API 구현", number: 12, body: nil, repository_url: "/Commit Generator", user: User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: "")),Issue(id: 12, title: "코드리뷰", number: 13, body: nil, repository_url: "/Commit Generator", user: User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: "")),
         Issue(id: 12, title: "로그인 API 구현", number: 12, body: nil, repository_url: "", user: User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: "")),Issue(id: 12, title: "코드리뷰", number: 13, body: nil, repository_url: "", user: User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: ""))]
    }
}
