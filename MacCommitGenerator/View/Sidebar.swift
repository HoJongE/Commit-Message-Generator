//
//  Sidebar.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/04.
//

import SwiftUI
import Foundation

struct Sidebar: View {
    
    @Binding var viewType: ContentView.ViewType?
    @State private var showResetAlert: Bool = false

    init(viewType: Binding<ContentView.ViewType?>) {
        self._viewType = viewType
    }
    
    var body: some View {
        List(selection: $viewType) {
            Section {
                SidebarLabel(title: "커밋 작성", image: Image(systemName: "pencil"))
                    .tag(ContentView.ViewType.commitWrite)
            } header: {
                Text("기능")
            }
            
            Section {
                SidebarLabel(title: "태그", image: Image(systemName: "tag.fill"))
                    .tag(ContentView.ViewType.editTag)
                SidebarLabel(title: "기능", image: Image(systemName: "square.and.pencil"))
                    .tag(ContentView.ViewType.editFunction)
                SidebarLabel(title: "리셋", image: Image("reset"))
                    .onTapGesture {
                        showResetAlert = true
                    }
            } header: {
                Text("편집")
            }
            
            Section {
                SidebarLabel(title: "깃허브 계정", image: Image("github"))
                    .tag(ContentView.ViewType.githubSetting)
            } header: {
                Text("설정")
            }
        }
        .alert(isPresented: $showResetAlert) {
            Alert(title: Text("태그를\n리셋하시겠습니까?"), message: nil, primaryButton: .destructive(Text("리셋"), action: reset), secondaryButton: .cancel())
        }
        .frame(width: 200)
    }
    
    private func reset() {
        PersistenceController.shared.reset()
    }
}
// MARK: - 리스트 백그라운드 제거

// MARK: - 사이드바 아이템
struct SidebarLabel: View {
    let title: String
    let image: Image
    
    var body: some View {
        Label(title: {Text(title).padding(.leading, 6)}, icon: {
            image.resizable().frame(width: 16, height: 16, alignment: .center)
        })
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(viewType: .constant(nil))
    }
}
