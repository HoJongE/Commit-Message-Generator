//
//  Tag.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import Foundation


struct Tag : Identifiable {
    
    let id = UUID()
    let name : String
    let tagDescription : String
    
    init(_ name : String,_ tagDescription : String) {
        self.name = name
        self.tagDescription = tagDescription
    }
}


extension Tag : CustomStringConvertible {
    var description: String {
        "\(id) 태그 이름: \(name) 태그 설명: \(tagDescription.prefix(10))"
    }
}


