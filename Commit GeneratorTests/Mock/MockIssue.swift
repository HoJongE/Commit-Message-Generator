//
//  MockIssue.swift
//  CommitGeneratorTests
//
//  Created by JongHo Park on 2022/03/18.
//

import Foundation
@testable import Commit_Generator

extension Issue {
    static var mockIssuesForFilter: [Issue] {
        [Issue(id: 10, title: "로그인 API 구현", number: 1, body: nil, repository_url: "https://github.com/HoJongPARK/Commit-Message-Generator", user: User(login: "HoJongPark", avatar_url: "", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil), Issue(id: 10, title: "로그인 API 구현", number: 1, body: nil, repository_url: "https://github.com/BaekHaeDream/GongGongE", user: User(login: "HoJongPark", avatar_url: "", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil), Issue(id: 10, title: "로그인 API 구현", number: 1, body: nil, repository_url: "https://github.com/HoJongPARK/BaekJoon-Profile", user: User(login: "HoJongPark", avatar_url: "", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil), Issue(id: 10, title: "로그인 API 구현", number: 1, body: nil, repository_url: "https://github.com/HoJongPARK/BaekJoon-Profile", user: User(login: "HoJongPark", avatar_url: "", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil)]
    }
    static var mockIssueForHoJongPARKAndBaekJoonProfile: [Issue] {
        [Issue(id: 10, title: "로그인 API 구현", number: 1, body: nil, repository_url: "https://github.com/HoJongPARK/BaekJoon-Profile", user: User(login: "HoJongPark", avatar_url: "", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil), Issue(id: 10, title: "로그인 API 구현", number: 1, body: nil, repository_url: "https://github.com/HoJongPARK/BaekJoon-Profile", user: User(login: "HoJongPark", avatar_url: "", gravatar_id: "", html_url: ""), milestone: nil, labels: nil, assignee: nil, assignees: nil)]
    }
}
