//
//  Setting.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/11.
//

import SwiftUI
import LaunchAtLogin

// MARK: - 세팅 호스트 뷰
struct Setting: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Github")
                .foregroundColor(.text3)
            GithubConnect()
            Divider()
            Text("설정")
                .foregroundColor(.text3)
            DefaultSetting()
            OpeningAtLogin()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(12)
    }
}
// MARK: - 커밋 자동 닫기 뷰
struct DefaultSetting: View {
    @AppStorage(Const.Setting.AUTO_CLOSE) private var autoClose: Bool = UserDefaults.standard.bool(forKey: Const.Setting.AUTO_CLOSE)
    
    var body: some View {
        Toggle("커밋 복사 시 자동으로 해결된 이슈 닫기", isOn: $autoClose)
            .toggleStyle(.checkbox)
    }
}
// MARK: - 로그인 시 자동 실행
struct OpeningAtLogin: View {
    var body: some View {
        LaunchAtLogin.Toggle {
            Text("로그인 시 자동 실행")
        }
    }
}
struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
            .environmentObject(Authentication())
    }
}
