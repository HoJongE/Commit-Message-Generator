//
//  WidgetView.swift
//  IssueWidgetExtension
//
//  Created by 박종호 on 2022/03/03.
//

import SwiftUI
import WidgetKit

struct IssueWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family: WidgetFamily
    var issues: Loadable<[Issue]>

    var body: some View {
        switch issues {
            case .empty, .loading:
                IssueErrorView(error: NetworkError.responseNotExist)
            case .error(error: let error):
                IssueErrorView(error: error)
            case .success(data: let data):
                MediumIssueList(issues: data)
        }
    }
}

struct MediumIssueList: View {
    let issues: [Issue]
    var body: some View {
        VStack {
            ProfileRow(user: issues[0].user)
            Divider().background(.gray)
            if issues.isEmpty {
                Spacer()
                Text("이슈가\n없습니다").foregroundColor(.white)
                Spacer()
            } else {
                ForEach(0..<min(3, issues.count)) { index in
                    IssueRow(issue: issues[index])
                    if index != min(issues.count, 3) - 1 {
                        Divider().background(.gray)
                    }
                }
                Spacer()
            }
        }.background(Color.black)
    }
}

struct IssueErrorView: View {
    let error: Error

    var body: some View {
        Text("이슈를 불러오는데 에러가 발생했습니다.\n\(error.localizedDescription)")
    }
}
struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IssueWidgetEntryView(issues: Loadable.success(data: Issue.mocIssue))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            IssueWidgetEntryView(issues: Loadable.success(data: Issue.mocIssue))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
