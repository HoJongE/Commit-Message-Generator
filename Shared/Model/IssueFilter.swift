//
//  IssueFilter.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/18.
//

import Foundation

struct IssueFilter {
    private var repository: String = "All"
    
    func filteredIssue(_ issues: [Issue]) -> [Issue] {
        return (try? issues.filter(compRepository(_:))) ?? []
    }
    
    func repositorys(origin issues: [Issue]) -> [String] {
        var ret: [String] = ["All"]
        for issue in issues {
            if !ret.contains(issue.repository) {
                ret.append(issue.repository)
            }
        }
        return ret
    }
    
    private func compRepository(_ issue: Issue) throws -> Bool {
        if repository != "All" {
            return issue.repository == repository
        } else {
            return true
        }
    }

    mutating func setRepository(_ repository: String) {
        self.repository = repository
    }
}
