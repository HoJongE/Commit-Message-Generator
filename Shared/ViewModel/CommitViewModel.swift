//
//  CommitViewModel.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import SwiftUI
import Combine
final class CommitViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var body: String = ""
    
    @Published var resolvedIssues: [Issue] = [Issue]()
    @Published var fixingIssues: [Issue] = [Issue]()
    @Published var refIssues: [Issue] = [Issue]()
    @Published var relatedIssues: [Issue] = [Issue]()
    
    @Published var selectedTag: Tag?
    @Published var selectedFunction: Tag?
    
    @Published var issues: Loadable<[Issue]> = Loadable.empty
    @Published var organization: String = "All"
    @Published var repository: String = "All"
    private var cancellableSet: Set<AnyCancellable> = []
    private (set) var issueFilter: IssueFilter = IssueFilter()
    
    var correctForm: Bool {
        selectedTag != nil && selectedFunction != nil && !title.isEmpty
    }
    
    var filteredIssues: [Issue] {
        switch self.issues {
        case .success(data: let data):
            return issueFilter.filteredIssue(data.filter { issue in
                !resolvedIssues.contains {selectedIssue in issue.id == selectedIssue.id} &&
                !fixingIssues.contains {selectedIssue in issue.id == selectedIssue.id} &&
                !refIssues.contains {selectedIssue in issue.id == selectedIssue.id} &&
                !relatedIssues.contains {selectedIssue in issue.id == selectedIssue.id}
                
            })
        default : return [Issue]()
        }
    }
    
    private let commitWriter: CommitWriter = CommitWriter()
    private let issueRepository: IssueRepository
    
    init(_ issueRepository: IssueRepository = DefaultIssueRepository.shared) {
        self.issueRepository = issueRepository
    }
    
    func selectTag(_ tag: Tag) {
        switch tag.category {
        case "태그" :
            selectedTag = tag
        case "기능":
            selectedFunction = tag
        default:
            print("알 수 없는 태그")
        }
    }
    
    func copyToClipboard(_ copyType: CopyType) -> Bool {
        closeResolvedIssue()
        return commitWriter.write(copyType: copyType, tag: selectedTag!, function: selectedFunction!, title: title, body: body, resolved: resolvedIssues, fixing: fixingIssues, ref: refIssues, related: relatedIssues)
        
    }
    private func closeResolvedIssue() {
        guard UserDefaults.standard.bool(forKey: "autoClose") else {
            return
        }
        
        for issue in resolvedIssues {
            issueRepository.closeIssue(issue)
        }
    }
    func reset() {
        title = ""
        body = ""
        resolvedIssues.removeAll()
        refIssues.removeAll()
        relatedIssues.removeAll()
        fixingIssues.removeAll()
        selectedTag = nil
        selectedFunction = nil
    }
    
    func getIssues(_ page: Int) {
        issues = Loadable.loading
        issueRepository.getIssues(page)
            .sink {
                self.issues = $0
                #if DEBUG
                print($0)
                #endif
            }
            .store(in: &cancellableSet)
    }
    func setRepository(_ repository: String) {
        self.repository = repository
        issueFilter.setRepository(repository)
    }
    func repositorys() -> [String] {
        if case let Loadable.success(data: data) = issues {
            return issueFilter.repositorys(origin: data)
        } else {
            return []
        }
    }
}
