//
//  CommitValidator.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

struct CommitValidator {
    func check(selectedTag : Tag?, selectedFunction : Tag?,title : String) -> Bool {
        selectedTag != nil && selectedFunction != nil && title.count > 0 
    }
}
