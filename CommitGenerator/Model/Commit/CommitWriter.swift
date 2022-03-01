//
//  CommitWriter.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

struct CommitWriter {
    func write(copyType : CopyType ,tag: Tag?,function: Tag?, title : String,body : String,resolved:[Issue],fixing:[Issue],ref:[Issue],related:[Issue]) throws -> String{
        
        switch copyType {
            case .TitleOnly:
                return try writeTitle(tag: tag, function: function, title: title)
            case .BodyOnly:
                return writeBody(body: body, resolved: resolved, fixing: fixing, ref: ref, related: related)
            case .All:
                return try writeTitle(tag: tag, function: function, title: title) + "\n" + writeBody(body: body, resolved: resolved, fixing: fixing, ref: ref, related: related)
        }
    }
    
    private func writeTitle(tag : Tag?, function : Tag?, title : String) throws -> String {
        
        guard let tag = tag,let function = function else {
            throw CommitError.InvalidForm
        }

        
        guard let tagName = tag.name,let functionName = function.name else {
            throw CommitError.InvalidForm
        }
        
        return tagName + ": " + functionName + " " + title
    }
    
    private func writeBody(body : String,resolved:[Issue],fixing:[Issue],ref:[Issue],related:[Issue])  -> String {
        var ret = body.count == 0 ? "" : body + "\n\n"
        
        ret += writeIssue(value: resolved,of: .Resolved)
        ret += writeIssue(value: fixing,of: .Fixing)
        ret += writeIssue(value: ref,of: .Ref)
        ret += writeIssue(value: related,of: .Related)
        
        return ret
    }
    
    private func writeIssue(value : [Issue],of type : IssueType) -> String {
        if value.count > 0 {
            var ret = "\(type.engTitle): "
            for i in 0..<value.count {
                if i != value.count - 1 {
                    ret += "#\(value[i].number), "
                } else {
                    ret += "#\(value[i].number)"
                }
            }
            return ret + "\n"
        }
        
        return ""
    }
    
    
    enum CommitError:Error {
        case InvalidForm
    }
}
