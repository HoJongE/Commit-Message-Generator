//
//  TagSettingView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

// MARK: - 태그 편집 버튼 뷰

extension SettingHost {

    struct TagSettingView: View {

        private let title: String
        private let systemName: String
        private let color: Color

        init(_ title: String, image systemName: String, tint color: Color) {
            self.title = title
            self.systemName = systemName
            self.color = color
        }

        var body: some View {

            HStack(alignment: .center) {
                Image(systemName: systemName)
                    .imageScale(.large)
                    .foregroundColor(color)
                Text(title)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.leading, 8)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 55, alignment: .leading)

        }
    }
}

// MARK: - 태그 리셋 버튼 뷰

extension SettingHost {

    struct ResetButton: View {

        @State private var showResetAlert = false

        var body: some View {
            HStack(alignment: .center) {
                Image("reset")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.indigo)
                Text("태그 리셋")
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding()
            .alert("태그를 리셋하시겠습니까?", isPresented: $showResetAlert) {
                Button("리셋", role: .destructive, action: resetTags)
            }
            .frame(maxWidth: .infinity, maxHeight: 55, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                showResetAlert = true
            }

        }
        private func resetTags() {
            PersistenceController.shared.reset()
        }
    }
}

struct TagSettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingHost.TagSettingView("태그", image: "tag.fill", tint: .brand)
            SettingHost.ResetButton()
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.background1)

    }
}
