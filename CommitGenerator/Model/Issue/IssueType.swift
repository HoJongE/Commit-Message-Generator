//
//  IssueType.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum IssueType : String {
    case Resolved = "해결한 이슈"
    case Fixing = "수정중인 이슈"
    case Ref = "참고할 이슈"
    case Related = "관련된 이슈"
}
