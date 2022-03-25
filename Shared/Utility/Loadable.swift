//
//  Lodable.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
// MARK: - Data 상태를 나타내는 유틸리티 열거형
enum Loadable<T> {
    case empty
    case loading
    case success(data: T)
    case error(error: Error)

    var value: T? {
        switch self {
            case .success(data: let data):
                return data
            default: return nil
        }
    }
    var error: Error? {
        switch self {
            case .error(error: let error):
                return error
            default: return nil
        }
    }
    var loading: Bool {
        switch self {
            case .loading: return true
            default : return false
        }
    }
}
// MARK: - Equatable 프로토콜 구현
extension Loadable: Equatable {

    static func == (lhs: Loadable, rhs: Loadable) -> Bool {
        switch (lhs, rhs) {
            case (Loadable.empty, Loadable.empty),
                (Loadable.loading, Loadable.loading),
                (Loadable.success(data: _), Loadable.success(data: _)),
                (Loadable.error(error: _), Loadable.error(error: _)):
                return true
            default:
                return false
        }
    }
}
// MARK: - description 이 구현된 모델에 대해 description 프로토콜 구현
extension Loadable: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        switch self {
            case .error(error: let error):
                #if DEBUG
                print(error)
                #endif
                return "data is error : \(error.localizedDescription)"

            case .loading: return "data is Loading"
            case .empty: return "data is Empty"
            case .success(data: let data): return data.description
        }
    }
}
