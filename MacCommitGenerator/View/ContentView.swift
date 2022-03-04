//
//  ContentView.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var viewType: ViewType? = nil
    
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
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: { // 1
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    var mainView: some View {
        switch self.viewType {
        case .none:
            return Text("")
        case .some(.commitWrite):
            return Text("commitWrite")
        case .some(.editTag):
            return Text("editTag")
        case .some(.editFunction):
            return Text("editFunction")
        case .some(.githubSetting):
            return Text("githubSetting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, MockedCoreData.shared.container.viewContext)
    }
}
