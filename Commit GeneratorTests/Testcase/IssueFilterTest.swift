//
//  IssueFilterTest.swift
//  CommitGeneratorTests
//
//  Created by JongHo Park on 2022/03/18.
//

import XCTest
@testable import Commit_Generator

class IssueFilterTest: XCTestCase {
    
    func testIssueFilter_WhenRepositoryIsBaekJoonProfile() {
        var issueFilter: IssueFilter = IssueFilter()
        issueFilter.setRepository("BaekJoon-Profile")
        XCTAssert(issueFilter.filteredIssue(Issue.mockIssuesForFilter) == Issue.mockIssueForHoJongPARKAndBaekJoonProfile, "HoJongPARK 조직 & 백준 프로필 레포에 맞지 않는 필터!")
    }
    
    func testIssueFilter_WhenFilterIsEmpty() {
        let issueFilter: IssueFilter = IssueFilter()
        XCTAssert(issueFilter.filteredIssue(Issue.mockIssuesForFilter) == Issue.mockIssuesForFilter, "빈 필터에 맞지 않는 이슈!")
    }
}
