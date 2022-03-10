//
//  Extension.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/08.
//

import Foundation

extension String {
    func getChar(at index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
