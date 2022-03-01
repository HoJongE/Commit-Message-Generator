//
//  Issue.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import SwiftUI

struct Issue : Codable,Hashable  {
   
    let title : String
    let number : Int
    let body : String?
    let repository_url : String
    let user : User
    
}

extension Issue : CustomStringConvertible {
    var description: String {
        "Issue Number:\(number) Issue Title:\(title) maker:\(user.login)"
    }
}
