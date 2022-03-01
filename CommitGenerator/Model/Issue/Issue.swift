//
//  Issue.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import SwiftUI

struct Issue : Hashable , Codable {
   
    let title : String
    let number : Int
    
}

extension Issue : CustomStringConvertible {
    var description: String {
        "Issue Number:\(number) Issue Title:\(title)"
    }
}
