//
//  User.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation

struct User: Codable, Hashable {
    let login: String
    let avatar_url: String
    let gravatar_id: String
    let html_url: String
}

extension User: CustomStringConvertible {
    var description: String {
        "login:\(login), avatar_url:\(avatar_url)"
    }
}
