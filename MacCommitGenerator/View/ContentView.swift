//
//  ContentView.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var viewType: ViewType? = .editTag
    
    enum ViewType: String, Equatable {
        case commitWrite
        case editTag
        case editFunction
        case githubSetting
        
        static func == (lhs: ViewType, rhs: ViewType) -> Bool {
            switch (lhs,rhs) {
            case (commitWrite,commitWrite),
                (editTag,editTag),
                (editFunction,editFunction),
                (githubSetting,githubSetting):
                return true
            default:
                return false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Sidebar(viewType: $viewType)
            mainView
        }
        .frame(height: viewType == .commitWrite ? 660 : 480 )
    }
    
    @ViewBuilder
    var mainView: some View {
        switch self.viewType {
        case .none:
            Text("")
        case .some(.commitWrite):
            CommitWriteHost()
        case .some(.editTag):
            TagList(category: "태그")
        case .some(.editFunction):
            TagList(category: "기능")
        case .some(.githubSetting):
            GithubConnect()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
                .preferredColorScheme(.light)
            ContentView()
                .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
                .preferredColorScheme(.dark)
        }
    }
}
