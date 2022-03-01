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
    
    
    //TODO: Test 용도 릴리즈 버전엔 없애야함!
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
        user = Lodable.Loading
        tokenManager.requestAccessToken(with: code) { result in
            switch result {
                    
                case .Success(data: let data):
                    _ = KeyChainManager.shared.deleteToken()
                    _ = KeyChainManager.shared.saveToken(data)
                    self.getUser()
                case .Error(error: let error):
                    self.user = Lodable.Error(error: error)
                default:
                    self.user = Lodable.Error(error: NetworkError.authenticationError)
            }
        }
    }
    
    func getUser() {
        user = Lodable.Loading
        githubService.getUser { result in
            self.user = result
        }
    }
    
    func logout() {
        _ = KeyChainManager.shared.deleteToken()
        user = Lodable.Empty
    }
}
