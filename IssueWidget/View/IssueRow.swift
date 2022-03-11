//
//  IssueRow.swift
//  IssueWidgetExtension
//
//  Created by 박종호 on 2022/03/03.
//

import SwiftUI
import WidgetKit

struct IssueRow: View {
    @Environment(\.widgetFamily) private var family: WidgetFamily

    let issue: Issue
    var body: some View {
        HStack {
            Text("#\(issue.number)").foregroundColor(.gray).font(.caption)
            Text(issue.title).foregroundColor(.white).font(.subheadline).fontWeight(.semibold).lineLimit(1)
            if family == .systemMedium {
                Text(issue.repository)
                    .font(.caption).foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(.vertical, 1)
        .padding(.horizontal, 4)
    }
}

struct CircleImage: View {
    let width: CGFloat
    let url: URL?
    var body: some View {
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                // 추가적인 이미지 처리는 여기서 가능하다.
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: width, height: width, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 3)
            } else {
                // 추가적인 이미지 처리는 여기서 가능하다.
                Image("placeholder-image")
            }
        }
    }
}

struct ProfileRow: View {
    let user: User
    var body: some View {
        HStack {
            Spacer()
            CircleImage(width: 24, url: URL(string: user.avatar_url))
            Text(user.login).foregroundColor(.white).font(.caption).fontWeight(.bold).lineLimit(1)
            Spacer()
        }
        .padding(.init(top: 8, leading: 8, bottom: 2, trailing: 8))
    }
}
struct IssueRow_Previews: PreviewProvider {
    static var previews: some View {
        IssueRow(issue: Issue.mocIssue[0])
            .background(.black)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewLayout(.sizeThatFits)
        ProfileRow(user: Issue.mocIssue[0].user)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .background(.black)
    }
}
