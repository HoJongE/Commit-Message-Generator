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
    
    var body: some View {
        List(selection: $viewType) {
            Section {
                SidebarLabel(title: "커밋 작성", image: Image(systemName: "pencil"), color: .yellow)
                    .tag(ContentView.ViewType.commitWrite)
            } header: {
                Text("기능")
            }
            
            Section {
                SidebarLabel(title: "태그", image: Image(systemName: "tag.fill"), color: .blue)
                    .tag(ContentView.ViewType.editTag)
                SidebarLabel(title: "기능", image: Image(systemName: "square.and.pencil"), color: .orange)
                    .tag(ContentView.ViewType.editFunction)
            } header: {
                Text("편집")
            }
            
            Section {
                SidebarLabel(title: "깃허브 계정", image: Image("github"), color: .blue)
                    .tag(ContentView.ViewType.githubSetting)
            } header: {
                Text("설정")
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 200)
    }
}

struct SidebarLabel: View {
    let title: String
    let image: Image
    let color: Color
    var body: some View {
        Label(title: {Text(title).padding(.leading,6).foregroundColor(.primary)}, icon: {image.resizable().frame(width: 16, height: 16, alignment: .center).foregroundColor(color)})
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(viewType: .constant(nil))
    }
}
