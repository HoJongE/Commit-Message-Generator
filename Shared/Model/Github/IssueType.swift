//
//  IssueType.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum IssueType {
    case resolved
    case fixing
    case ref
    case related

    var korTitle: String {
        switch self {
            case .resolved:
                return "해결한 이슈"
            case .fixing:
                return "수정중인 이슈"
            case .ref:
                return "참고할 이슈"
            case .related:
                return "관련된 이슈"
        }
    }

    var engTitle: String {
        switch self {
            case .resolved:
                return "Resolves"
            case .fixing:
                return "Fixes"
            case .ref:
                return "Ref"
            case .related:
                return "Related to"
        }
    }
}
