//
//  NetworkError.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum NetworkError: Error {
    case error304
    case error404
    case error422
    case responseNotExist
    case authenticationError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .error304: return NSLocalizedString("Error 304", comment: "")
            case .error404: return NSLocalizedString("Error 404", comment: "")
            case .error422: return NSLocalizedString("Error 422", comment: "")
            case .responseNotExist: return NSLocalizedString("Response Not Exist", comment: "")
            case .authenticationError: return NSLocalizedString("사용자 인증 에러\n설정에서 로그인을 다시 진행해주세요", comment: "")
        }
    }
}
