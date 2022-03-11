//
//  CommitViewModel.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
#if canImport(Appkit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif
import SwiftUI

final class CommitViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var body: String = ""
    
    @Published var resolvedIssues: [Issue] = [Issue]()
    @Published var fixingIssues: [Issue] = [Issue]()
    @Published var refIssues: [Issue] = [Issue]()
    @Published var relatedIssues: [Issue] = [Issue]()
    
    @Published var selectedTag: Tag?
    @Published var selectedFunction: Tag?
    
    @Published var issues: Lodable<[Issue]> = Lodable.empty
    
    var filteredIssues: [Issue] {
        switch self.issues {
        case .success(data: let data):
            return data.filter { issue in
                !resolvedIssues.contains {selectedIssue in issue.id == selectedIssue.id} &&
                !fixingIssues.contains {selectedIssue in issue.id == selectedIssue.id} &&
                !refIssues.contains {selectedIssue in issue.id == selectedIssue.id} &&
                !relatedIssues.contains {selectedIssue in issue.id == selectedIssue.id}
            }
        default : return [Issue]()
        }
    }
    
    private let commitWriter: CommitWriter = CommitWriter()
    
    private let githubService: GithubService
    
    init(githubService: GithubService = GithubService.shared) {
        self.githubService = githubService
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
        do {
            #if canImport(UIKit)
            try UIPasteboard.general.string = commitWriter.write(copyType: copyType, tag: selectedTag, function: selectedFunction, title: title, body: body, resolved: resolvedIssues, fixing: fixingIssues, ref: refIssues, related: relatedIssues)
            #endif
            
            #if canImport(AppKit)
            let pasteboard: NSPasteboard = NSPasteboard.general
            pasteboard.clearContents()
            try pasteboard.setString(commitWriter.write(copyType: copyType, tag: selectedTag, function: selectedFunction, title: title, body: body, resolved: resolvedIssues, fixing: fixingIssues, ref: refIssues, related: relatedIssues), forType: .string)
            #endif
            closeResolvedIssue()
            return true
        } catch {
            return false
        }
    }
    private func closeResolvedIssue() {
        guard UserDefaults.standard.bool(forKey: "autoClose") else {
            return
        }
        
        for issue in resolvedIssues {
            githubService.closeIssue(issue)
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
        githubService.getIssues(page) { result in
            withAnimation {
                self.issues = result
            }
        }
    }
}
