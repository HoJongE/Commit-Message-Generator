//
//  IssueWidget.swift
//  IssueWidget
//
//  Created by 박종호 on 2022/03/03.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> IssueEntry {
        IssueEntry(date: Date(), issues: Lodable.success(data: Issue.mocIssues))
    }

    func getSnapshot(in context: Context, completion: @escaping (IssueEntry) -> Void) {
        let entry = IssueEntry(date: Date(), issues: Lodable.success(data: Issue.mocIssues))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let updateInterval = 120
        let date = Date()

        let nextUpdateDate: Date = Calendar.current.date(byAdding: .minute, value: updateInterval, to: date)!

        let entry = Entry(date: date, issues: Lodable.success(data: Issue.mocIssues))
        let timeLine = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeLine)
        // TODO: 깃허브 서비스 연동해야함
//        GithubService.shared.getIssues(1) { result in
//            let entry = Entry(date: date, issues: result)
//            let timeLine = Timeline(entries: [entry], policy: .after(nextUpdateDate))
//            completion(timeLine)
//        }
    }
}

struct IssueEntry: TimelineEntry {
    let date: Date
    let issues: Lodable<[Issue]>
}

@main
struct IssueWidget: Widget {
    let kind: String = "per.jongho.issuewidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            IssueWidgetEntryView(issues: entry.issues)
        }
        .configurationDisplayName("이슈 위젯")
        .description("이슈를 리스트 형식으로 보여주는 위젯입니다")
    }
}
