//
//  Setting.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/11.
//

import SwiftUI

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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(12)
    }
}

struct DefaultSetting: View {
    @AppStorage("autoClose") private var autoClose: Bool = UserDefaults.standard.bool(forKey: "autoClose")
    
    var body: some View {
        automaticClosing
    }
    
    private var automaticClosing: some View {
        Toggle("커밋 복사 시 자동으로 해결된 이슈 닫기", isOn: $autoClose)
            .toggleStyle(.checkbox)
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
            .environmentObject(Authentication())
    }
}
