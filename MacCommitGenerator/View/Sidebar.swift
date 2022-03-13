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
        VStack(alignment: .leading, spacing: 12) {
            Text("기능").foregroundColor(.text3).font(.subheadline)
            SidebarLabel(title: "커밋 작성", image: Image(systemName: "pencil"), selected: viewType == .commitWrite) {
                changeView(.commitWrite)
            }
            Text("편집").foregroundColor(.text3).font(.subheadline)
            SidebarLabel(title: "태그", image: Image(systemName: "tag.fill"), selected: viewType == .editTag) {
                changeView(.editTag)
            }
            SidebarLabel(title: "기능", image: Image(systemName: "square.and.pencil"), selected: viewType == .editFunction) {
                changeView(.editFunction)
            }
            SidebarLabel(title: "리셋", image: Image("reset"), selected: false) {
                showResetAlert = true
            }
            Text("설정").foregroundColor(.text3).font(.subheadline)
            SidebarLabel(title: "설정", image: Image(systemName: "gear"), selected: viewType == .githubSetting) {
                changeView(.githubSetting)
            }
            SidebarLabel(title: "커밋 스타일", image: Image(systemName: "pencil.and.outline"), selected: viewType == .commitStyleGuide) {
                changeView(.commitStyleGuide)
            }
        }
        .alert(isPresented: $showResetAlert) {
            Alert(title: Text("태그를\n리셋하시겠습니까?"), message: nil, primaryButton: .destructive(Text("리셋"), action: reset), secondaryButton: .cancel())
        }
        .padding()
        .frame(maxWidth: 250, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private func changeView(_ viewType: ContentView.ViewType) {
        self.viewType = viewType
    }
    
    private func reset() {
        PersistenceController.shared.reset()
    }
}
// MARK: - 사이드바 아이템
struct SidebarLabel: View {
    let title: String
    let image: Image
    let selected: Bool
    let changeView: () -> Void
    
    var body: some View {
        Label(title: {Text(title).padding(.leading, 6)}, icon: {
            image.resizable().foregroundColor(.brand).frame(width: 16, height: 16, alignment: .center)
        })
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(controlBackground)
            .contentShape(Rectangle())
            .onTapGesture(perform: changeView)
    }
    @ViewBuilder
    private var controlBackground: some View {
        if selected {
            RoundedRectangle(cornerRadius: 6).fill(.white.opacity(0.1))
                .padding(-6)
        } else {
            Color.clear
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(viewType: .constant(nil))
    }
}
