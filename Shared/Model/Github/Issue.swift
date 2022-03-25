//
//  Issue.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import SwiftUI

struct Issue: Codable, Hashable {
    let id: Int
    let title: String
    let number: Int
    let body: String?
    let repository_url: String
    let user: User
    let milestone: Milestone?
    let labels: [Label]?
    let assignee: Assignee?
    let assignees: [Assignee]?
}
extension Issue: CustomStringConvertible {
    var description: String {
        "Issue Number:\(number) Issue Title:\(title) maker:\(user.login) assignee:\(assignee?.login ?? "")"
    }
}

extension Issue {
    var repository: String {
        String(repository_url.split(separator: "/").last ?? "")
    }
    
    var organization: String {
        String(repository_url.split(separator: "/").dropLast().last ?? "")
    }
}

extension Issue {
    // MARK: - Label
    struct Label: Codable, Hashable {
        let id: Int
        let nodeID: String
        let url: String
        let name, labelDescription, color: String
        let labelDefault: Bool

        enum CodingKeys: String, CodingKey {
            case id
            case nodeID = "node_id"
            case url, name
            case labelDescription = "description"
            case color
            case labelDefault = "default"
        }
    }
}

extension Issue {
    // MARK: - Milestone
    struct Milestone: Codable, Hashable {
        let url: String
        let htmlURL: String
        let labelsURL: String
        let id: Int
        let nodeID: String
        let number: Int
        let state, title, milestoneDescription: String
        let creator: Assignee
        let openIssues, closedIssues: Int
        let createdAt, updatedAt, closedAt, dueOn: Date

        enum CodingKeys: String, CodingKey {
            case url
            case htmlURL = "html_url"
            case labelsURL = "labels_url"
            case id
            case nodeID = "node_id"
            case number, state, title
            case milestoneDescription = "description"
            case creator
            case openIssues = "open_issues"
            case closedIssues = "closed_issues"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case closedAt = "closed_at"
            case dueOn = "due_on"
        }
    }
}
extension Issue {
    // MARK: - Assignee
    struct Assignee: Codable, Hashable {
        let login: String
        let id: Int
        let nodeID: String
        let avatarURL: String
        let gravatarID: String
        let url, htmlURL, followersURL: String
        let followingURL, gistsURL, starredURL: String
        let subscriptionsURL, organizationsURL, reposURL: String
        let eventsURL: String
        let receivedEventsURL: String
        let type: String
        let siteAdmin: Bool

        enum CodingKeys: String, CodingKey {
            case login, id
            case nodeID = "node_id"
            case avatarURL = "avatar_url"
            case gravatarID = "gravatar_id"
            case url
            case htmlURL = "html_url"
            case followersURL = "followers_url"
            case followingURL = "following_url"
            case gistsURL = "gists_url"
            case starredURL = "starred_url"
            case subscriptionsURL = "subscriptions_url"
            case organizationsURL = "organizations_url"
            case reposURL = "repos_url"
            case eventsURL = "events_url"
            case receivedEventsURL = "received_events_url"
            case type
            case siteAdmin = "site_admin"
        }
    }
}
