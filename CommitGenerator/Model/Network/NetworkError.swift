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
}
