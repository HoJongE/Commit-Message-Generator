//
//  Authentication.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation
import SwiftUI

final class Authentication: ObservableObject {
    @Published var user: Lodable<User> = Lodable.empty

    private let tokenManager: TokenManager
    private let githubService: GithubService

    init(tokenManager: TokenManager = TokenManager.shared, githubService: GithubService = GithubService.shared) {
        self.tokenManager = tokenManager
        self.githubService = githubService
        getUser()
    }

    #if os(iOS)
    func requestCode() {
        let scope: String = "repo,user"
        let urlString: String = "https://github.com/login/oauth/authorize?client_id=\(Const.GitHub.CLIEND_ID)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    #endif
    
    #if os(macOS)
    func requestCode() {
        let scope: String = "repo,user"
        let urlString: String = "https://github.com/login/oauth/authorize?client_id=\(Const.GitHub.CLIEND_ID)&scope=\(scope)"
        if let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
    }
    #endif

    func requestAccessToken(with code: String) {
        user = Lodable.loading
        tokenManager.requestAccessToken(with: code) { result in
            switch result {

                case .success(data: let data):
                    _ = KeyChainManager.shared.deleteToken()
                    _ = KeyChainManager.shared.saveToken(data)
                    self.getUser()
                case .error(error: let error):
                    self.user = Lodable.error(error: error)
                default:
                    self.user = Lodable.error(error: NetworkError.authenticationError)
            }
        }
    }

    func getUser() {
        user = Lodable.loading
        githubService.getUser { result in
            self.user = result
        }
    }

    func logout() {
        _ = KeyChainManager.shared.deleteToken()
        user = Lodable.empty
    }
}
