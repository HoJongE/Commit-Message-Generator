//
//  CommitWriter.swift
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

struct CommitWriter {
    func write(copyType: CopyType, tag: Tag, function: Tag, title: String, body: String, resolved: [Issue], fixing: [Issue], ref: [Issue], related: [Issue]) -> Bool {

        do {
            switch copyType {
            case .titleOnly:
                try copyToClipboard(writeTitle(tag: tag, function: function, title: title))
            case .bodyOnly:
                try copyToClipboard(writeBody(body: body, resolved: resolved, fixing: fixing, ref: ref, related: related))
            case .all:
                try copyToClipboard(writeTitle(tag: tag, function: function, title: title) + "\n\n" + writeBody(body: body, resolved: resolved, fixing: fixing, ref: ref, related: related))
            }
            return true
        } catch {
            return false
        }
    }

    private func copyToClipboard(_ value: String) throws {
#if canImport(UIKit)
        UIPasteboard.general.string = value
#endif
        
#if canImport(AppKit)
        let pasteboard: NSPasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(value, forType: .string)
        #endif
    }
    
    private func writeTitle(tag: Tag, function: Tag, title: String) throws -> String {

        guard let tagName = tag.name, let functionName = function.name else {
            throw CommitError.invalidForm
        }

        return tagName + ": " + functionName + " " + title
    }

    private func writeBody(body: String, resolved: [Issue], fixing: [Issue], ref: [Issue], related: [Issue]) -> String {
        var ret = body.count == 0 ? "" : body + "\n\n"

        ret += writeIssue(value: resolved, of: .resolved)
        ret += writeIssue(value: fixing, of: .fixing)
        ret += writeIssue(value: ref, of: .ref)
        ret += writeIssue(value: related, of: .related)

        return ret
    }

    private func writeIssue(value: [Issue], of type: IssueType) -> String {
        if value.count > 0 {
            var ret = "\(type.engTitle): "
            for index in 0..<value.count {
                if index != value.count - 1 {
                    ret += "#\(value[index].number), "
                } else {
                    ret += "#\(value[index].number)"
                }
            }
            return ret + "\n"
        }

        return ""
    }

    enum CommitError: Error {
        case invalidForm
    }
}
