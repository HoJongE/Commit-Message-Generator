//
//  Tag.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import Foundation


struct Tag : Hashable {
    
    let name : String
    let tagDescription : String
    let colorHex : String
    
    init(_ name : String,_ tagDescription : String,color : String) {
        self.name = name
        self.tagDescription = tagDescription
        self.colorHex = color
        
    }
    
    public static func == (lhs : Tag, rhs : Tag) -> Bool {
        return lhs.name == rhs.name
    }
}


extension Tag : CustomStringConvertible {
    var description: String {
        "태그 이름: \(name) 태그 설명: \(tagDescription.prefix(10))"
    }
}

#if DEBUG
extension Tag {
    static func provideDummyTags() -> [Tag] {
        [Tag("기능", "새로운 기능을 추가", color: "#123456"),Tag("Feat", "", color: "#123456")
         ,Tag("Rename", "버그를 고친 경우", color: "#123456")
         ,Tag("Chore", "사용자 UI 디자인 변경", color: "#123456")
         ,Tag("Test", "급하게 치명적인 버그를 고쳐야하는 경우", color: "#123456")
         ,Tag("Chrome", "코드 포맷 변경, 세미 클론 누락", color: "#123456")]
    }
}
#endif
