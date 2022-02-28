//
//  Issue.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import SwiftUI

struct Issue : Hashable {
    let issueNumber : Int
    let issueType : IssueType
    let color : Color
    
    init(_ issueNumber : Int,_ issueType : IssueType ){
        self.issueNumber = issueNumber
        self.issueType = issueType
        color = Color.random
    }
    
}
