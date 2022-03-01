//
//  Authentication.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation
import SwiftUI

final class Authentication : ObservableObject {
    @Published var user : Lodable<User> = Lodable.Empty
    
    private let tokenManager : TokenManager
    private let githubService : GithubService
    
    
    init(tokenManager : TokenManager = TokenManager.shared,githubService: GithubService = GithubService.shared) {
        self.tokenManager = tokenManager
        self.githubService = githubService
        getUser()
    }
    
    func requestCode() {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(Const.GitHub.CLIEND_ID)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestAccessToken(with code: String) {
        tokenManager.requestAccessToken(with: code) { result in
            switch result {
                    
                case .Success(data: let data):
                    KeyChainManager.shared.deleteToken()
                    KeyChainManager.shared.saveToken(data)
                    self.getUser()
                case .Error(error: let error):
                    self.user = Lodable.Error(error: error)
                default:
                    self.user = Lodable.Error(error: NetworkError.authenticationError)
            }
        }
    }
    
    func getUser() {
        githubService.getUser { result in
            self.user = result
        }
    }
    
    func logout() {
        KeyChainManager.shared.deleteToken()
        user = Lodable.Empty
    }
}
