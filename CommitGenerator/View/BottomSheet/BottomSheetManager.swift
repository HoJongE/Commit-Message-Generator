//
//  BottomSheetManager.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation

final class BottomSheetManager: ObservableObject {
    @Published var isPresent: Bool = false
    private(set) var action: Action = .none

    func openGithubLogin() {
        action = .githubLogin
        isPresent = true
    }

    enum Action: String {
        case githubLogin = "깃허브 로그인"
        case none = "없음"
    }

}
