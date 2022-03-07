//
//  Lodable.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum Lodable<T> {
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

extension Lodable: Equatable {

    static func == (lhs: Lodable, rhs: Lodable) -> Bool {
        switch (lhs, rhs) {
            case (Lodable.empty, Lodable.empty),
                (Lodable.loading, Lodable.loading),
                (Lodable.success(data: _), Lodable.success(data: _)),
                (Lodable.error(error: _), Lodable.error(error: _)):
                return true
            default:
                return false
        }
    }

}
extension Lodable: CustomStringConvertible where T: CustomStringConvertible {
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
