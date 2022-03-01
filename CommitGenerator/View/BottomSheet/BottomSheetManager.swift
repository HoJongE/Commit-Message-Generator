//
//  BottomSheetManager.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation


class BottomSheetManager : ObservableObject {
    @Published var isPresent : Bool = false
    private(set) var action = Action.None
    
    func openGithubLogin() {
        action = .GithubLogin
        isPresent = true
    }
    
    enum Action : String {
        case GithubLogin = "깃허브 로그인"
        case None = "없음"
    }
    
}
