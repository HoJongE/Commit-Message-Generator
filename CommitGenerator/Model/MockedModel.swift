//
//  MockedData.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//


#if DEBUG
import Foundation
import SwiftUI

extension PreviewDevice {
    static let mock : [String] = ["iPhone 12 Pro","iPhone SE (2nd generation)","iPhone 8","iPhone 12 mini"]
}

extension Issue {
    static let mocIssue : [Issue] = [Issue(title: "하이", number: 5),Issue(title: "하이", number: 5),Issue(title: "하이", number: 5),Issue(title: "하이", number: 5),Issue(title: "하이", number: 5)]
}

#endif
