//
//  IssueType.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum IssueType{
    case Resolved
    case Fixing
    case Ref
    case Related
    
    var korTitle : String {
        switch self {
            case .Resolved:
                return "해결한 이슈"
            case .Fixing:
                return "수정중인 이슈"
            case .Ref:
                return "참고할 이슈"
            case .Related:
                return "관련된 이슈"
        }
    }
    
    var engTitle : String {
        switch self {
            case .Resolved:
                return "Resolves"
            case .Fixing:
                return "Fixes"
            case .Ref:
                return "Ref"
            case .Related:
                return "Related to"
        }
    }
}
