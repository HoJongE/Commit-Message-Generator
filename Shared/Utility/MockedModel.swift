//
//  MockedData.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import Foundation
import SwiftUI

extension PreviewDevice {
    static let mock: [String] = ["iPhone 12 Pro", "iPhone SE (2nd generation)", "iPhone 8", "iPhone 12 mini"]
}

extension Issue {
    static var mocIssue: [Issue] {
        var ret: [Issue] = [Issue]()
        for _ in 0...10 {
            ret.append(Issue(id: 12, title: "로그인 API 구현", number: 12, body: "", repository_url: "Commit Generator", user: User(login: "HoJonsPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil))
        }
        return ret
    }
}
#if DEBUG
extension User {
    static func mocUser() -> User {
        User(login: "HoJongPARK", avatar_url: "https://avatars.githubusercontent.com/u/57793298?v=4", gravatar_id: "", html_url: "https://github.com/HoJongPARK")
    }
}

#endif
