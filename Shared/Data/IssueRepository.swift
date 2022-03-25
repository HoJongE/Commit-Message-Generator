//
//  IssueRepository.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/14.
//

import Foundation
import Combine

// MARK: - Issue Repository 프로토콜
protocol IssueRepository {
    func getIssues(_ page: Int) -> AnyPublisher<Loadable<[Issue]>, Never>
    func closeIssue(_ issue: Issue)
}
// MARK: - Issue Repository 인스턴스
final class DefaultIssueRepository {
    static let shared: IssueRepository = DefaultIssueRepository()
    
    private let githubService: GithubServiceProtocol
    
    init(_ githubService: GithubServiceProtocol = GithubService.shared) {
        self.githubService = githubService
    }
}
// MARK: - 프로토콜 구현부
extension DefaultIssueRepository: IssueRepository {
    func getIssues(_ page: Int) -> AnyPublisher<Loadable<[Issue]>, Never> {
        return githubService.getIssues(page)
    }
    
    func closeIssue(_ issue: Issue) {
        githubService.closeIssue(issue)
    }
}
