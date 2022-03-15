//
//  Authentication.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation
import SwiftUI
import Combine

final class Authentication: ObservableObject {
    @Published var user: Loadable<User> = Loadable.empty
    @Published var deviceflowResult: Loadable<DeviceflowResult> = Loadable.empty
    
    private let userRepository: UserRepository

    private var cancellableSet: Set<AnyCancellable> = []
    
    init(userRepository: UserRepository = DefaultUserRepository.shared) {
        self.userRepository = userRepository
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

    func requestAccessToken(with code: String) {
        user = Loadable.loading
        userRepository.requestAccessToken(with: code)
            .sink {
                switch $0 {
                case .success(data: let code):
                    _ = KeyChainManager.shared.deleteToken()
                   _ = KeyChainManager.shared.saveToken(code)
                   self.getUser()
                case .error(error: let error):
                    self.user = Loadable.error(error: error)
                default:
                    self.user = Loadable.error(error: NetworkError.authenticationError)
                }
            }.store(in: &cancellableSet)
    }

    func getUser() {
        user = Loadable.loading
        userRepository.getUser()
            .sink {
            self.user = $0
        }
            .store(in: &cancellableSet)
    }

    func logout() {
        _ = KeyChainManager.shared.deleteToken()
        user = Loadable.empty
    }
    
    #if os(macOS)
    func deviceflow() {
        userRepository.deviceflow()
            .sink {
                self.deviceflowResult = $0
            }
            .store(in: &cancellableSet)
    }
    
    func copyCode() {
        guard case Loadable.success(data: let data) = deviceflowResult else {
            return
        }
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(data.user_code, forType: .string)
        if let url = URL(string: data.verification_uri) {
            NSWorkspace.shared.open(url)
        }
    }
    
    func requestAccessTokenWithDeviceCode() {
        guard case Loadable.success(data: let data) = deviceflowResult else {
            return
        }
        user = Loadable.loading
        userRepository.requestAccessToken(with: data.device_code)
            .sink {
                switch $0 {
                case .success(data: let code):
                    _ = KeyChainManager.shared.deleteToken()
                   _ = KeyChainManager.shared.saveToken(code)
                   self.getUser()
                case .error(error: let error):
                    self.user = Loadable.error(error: error)
                default:
                    self.user = Loadable.error(error: NetworkError.authenticationError)
                }
            }.store(in: &cancellableSet)
    }
    #endif
}
