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
    
    enum ViewType: String {
        case commitWrite
        case editTag
        case editFunction
        case githubSetting
    }
    
    var body: some View {
        NavigationView {
            Sidebar(viewType: $viewType)
            mainView
        }
    }
    
    @ViewBuilder
    var mainView: some View {
        switch self.viewType {
        case .none:
            Text("")
        case .some(.commitWrite):
            Text("commitWrite")
        case .some(.editTag):
            TagList(category: "태그")
        case .some(.editFunction):
            TagList(category: "기능")
        case .some(.githubSetting):
            Text("githubSetting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
    }
}
