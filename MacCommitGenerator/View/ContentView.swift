//
//  ContentView.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var viewType: ViewType? = .commitWrite
    
    var body: some View {
        NavigationView {
            Sidebar(viewType: $viewType)
            mainView
        }
        .frame(width: viewType?.width ?? 500, height: viewType?.height ?? 480)
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
            Setting()
        case .some(.commitStyleGuide):
            CommitStyleGuide()
        }
    }
}
// MARK: - 사이드바 뷰 타입
extension ContentView {
    enum ViewType: Equatable {
        case commitWrite
        case editTag
        case editFunction
        case githubSetting
        case commitStyleGuide
        
        static func == (lhs: ViewType, rhs: ViewType) -> Bool {
            switch (lhs, rhs) {
            case (commitWrite, commitWrite),
                (editTag, editTag),
                (editFunction, editFunction),
                (githubSetting, githubSetting),
                (commitStyleGuide, commitStyleGuide):
                return true
            default:
                return false
            }
        }
        
        var height: CGFloat {
            switch self {
            case .commitWrite:
                return 660
            case .editFunction:
                return 480
            case .editTag:
                return 480
            case .githubSetting:
                return 300
            case .commitStyleGuide:
                return 300
            }
        }
        
        var width: CGFloat {
            switch self {
            case .commitWrite:
                return 800
            case .editTag:
                return 800
            case .editFunction:
                return 800
            case .githubSetting:
                return 650
            case .commitStyleGuide:
                return 650
            }
        }
    }
}
// MARK: - 루트뷰 프리뷰
#if DEBUG
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
#endif
