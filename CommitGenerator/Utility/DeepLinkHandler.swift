//
//  DeepLinkHandler.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

struct DeepLinkHandler {
    func openLink(with url : URL,authentication : Authentication) {
        if url.absoluteString.starts(with: Const.URL.URL_TYPE.appending("login")){
            if let code = url.absoluteString.split(separator: "=").last.map({String($0)}) {
                authentication.requestAccessToken(with: code)
            }
        }
    }
}
