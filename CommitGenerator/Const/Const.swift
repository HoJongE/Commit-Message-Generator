//
//  Const.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

struct Const {
    
}

extension Const {
    struct URL {
        static let GITHUB_AUTHORIZE = "https://github.com/login/oauth/authorize"
        static let GITHUB_ACCESS_TOKEN = "https://github.com/login/oauth/access_token"
        static let URL_TYPE = "commitgenerator://"
        static let GITHUB_ISSUE = "https://api.github.com/issues"
        static let GITHUB_USER = "https://api.github.com/user"
    }
}

extension Const {
    struct GitHub {
        static let CLIEND_ID = "5694f3a7b70d36a21953"
        static let CLIENT_SECRET = "3ea9b462a5bcc08c75e6664e43929c58a9738d3a"
    }
}
