//
//  MockedData.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//


#if DEBUG
import Foundation
import SwiftUI

extension PreviewDevice {
    static let mock : [String] = ["iPhone 12 Pro","iPhone SE (2nd generation)","iPhone 8","iPhone 12 mini"]
}

extension Issue {
    static var mocIssue : [Issue] {
        var ret = [Issue]()
        for _ in 0...10 {
            ret.append(Issue(id:18,title: "Github 로그인 flow 수정", number: 5,body: "안녕하세요 이것은 이슈입니다.",repository_url: "/Commit-Generator", user: User(login: "HoJongPARK", avatar_url: "", gravatar_id: "", html_url: "")))
        }
        return ret
    }
}

#endif
