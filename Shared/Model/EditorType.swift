//
//  EditorType.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import Foundation

enum EditorType {
    case title
    case body
}

extension EditorType {
    var title: String {
        switch self {
            case .title:
                return "제목"
            case .body :
                return "본문"
        }
    }

    var guideText: String {
        switch self {
            case .title : return "제목은 50자 이내로 작성하세요\n마지막에 특수문자는 삽입하지 마세요"
            case .body : return "본문은 한 줄당 72자 내로 작성하세요\n양에 구애받지 않고 최대한 상세하게 작성하세요\n무엇을 왜 변경했는지 설명하세요"
        }
    }

    var textLimit: Int {
        switch self {
            case .title : return 50
            case .body : return 1000
        }
    }
}
