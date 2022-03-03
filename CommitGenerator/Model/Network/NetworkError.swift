//
//  NetworkError.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum NetworkError : Error {
    case Error304
    case Error404
    case Error422
    case ResponseNotExist
    case authenticationError
}

extension NetworkError : LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .Error304: return NSLocalizedString("Error 304", comment: "")
            case .Error404: return NSLocalizedString("Error 404", comment: "")
            case .Error422: return NSLocalizedString("Error 422", comment: "")
            case .ResponseNotExist: return NSLocalizedString("Response Not Exist", comment: "")
            case .authenticationError: return NSLocalizedString("사용자 인증 에러\n설정에서 로그인을 다시 진행해주세요", comment: "")
        }
    }
}
