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
            .settingRow()
        }
    }
}

// MARK: - 태그 리셋 버튼 뷰

extension SettingHost {

    struct ResetButton: View {

        @State private var showResetAlert = false
        let reset: () -> Void
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
            .alert("태그를 리셋하시겠습니까?", isPresented: $showResetAlert) {
                Button("리셋", role: .destructive, action: reset)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                showResetAlert = true
            }
            .settingRow()
        }
    }
}
// MARK: - 이슈 자동 닫기 뷰
extension SettingHost {
    struct CloseResovledIssue: View {
        @AppStorage("autoClose") private var autoClose: Bool = UserDefaults.standard.bool(forKey: "autoClose")
        
        var body: some View {
            HStack(alignment: .center) {
                Image(systemName: "icloud.and.arrow.up.fill")
                    .imageScale(.large)
                    .foregroundColor(.brand)
                Toggle("커밋 복사 시 이슈 자동 닫기", isOn: $autoClose)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
            }
            .settingRow()
        }
    }
}
// MARK: - 커밋 스타일
extension SettingHost {
    struct CommitStyle: View {
        var body: some View {
            NavigationLink(destination: CommitStyleGuide()) {
                HStack {
                    Image(systemName: "pencil.and.outline")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                    Text("커밋 스타일")
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
                .settingRow()
            }
        }
    }
}
// MARK: - Setting row 사이즈 세팅
extension View {
    fileprivate func settingRow() -> some View {
        self
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 55, alignment: .leading)
    }
}
struct TagSettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingHost.TagSettingView("태그", image: "tag.fill", tint: .brand)
            SettingHost.ResetButton {}
            SettingHost.CloseResovledIssue()
            SettingHost.CommitStyle()
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.background1)

    }
}
