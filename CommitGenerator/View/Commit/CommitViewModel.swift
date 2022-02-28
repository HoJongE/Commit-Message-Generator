//
//  CommitViewModel.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import UIKit


extension CommitWriteHost {
    
    class CommitViewModel : ObservableObject {
        
        @Published var title : String
        @Published var body : String
        
        @Published var resolvedIssues : [Issue]
        @Published var fixingIssues : [Issue]
        @Published var refIssues : [Issue]
        @Published var relatedIssues : [Issue]
        
        @Published var selectedTag : Tag?
        @Published var selectedFunction : Tag?
        
        var validation : Bool {
            commitValidator.check(selectedTag: selectedTag, selectedFunction: selectedFunction, title: title)
        }
        
        private let commitValidator : CommitValidator = CommitValidator()
        private let commitWriter : CommitWriter = CommitWriter()
        
        init() {
            title = ""
            body = ""
            resolvedIssues = [Issue]()
            fixingIssues = [Issue]()
            refIssues = [Issue]()
            relatedIssues = [Issue]()
        }
        
        func selectTag(_ tag : Tag) {
            
            switch tag.category {
                case "태그" :
                    selectedTag = tag
                case "기능":
                    selectedFunction = tag
                default:
                    print("알 수 없는 태그")
            }
        }
        
        func addIssue(_ issue:Issue){
            switch issue.issueType {
                case .Resolved:
                    resolvedIssues.append(issue)
                case .Fixing:
                    fixingIssues.append(issue)
                case .Ref:
                    refIssues.append(issue)
                case .Related:
                    relatedIssues.append(issue)
            }
        }
        
        
        func copyToClipboard(_ copyType:CopyType) {
            do {
                try UIPasteboard.general.string = commitWriter.write(copyType: copyType, tag: selectedTag, function: selectedFunction, title: title, body: body, resolved: resolvedIssues, fixing: fixingIssues, ref: refIssues, related: relatedIssues)
            } catch {
                print(error.localizedDescription)
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
    }
}
