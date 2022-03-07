//
//  MacCommitGeneratorApp.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/04.
//

import SwiftUI

@main
struct MacCommitGeneratorApp: App {
    private let persistenceController: PersistenceController = PersistenceController.shared
    @StateObject private var commitViewModel: CommitViewModel = CommitViewModel()
    
    init() {
        if !UserDefaults.standard.bool(forKey: "first_time") {
            print("리셋!!")
            persistenceController.reset()
            UserDefaults.standard.set(true, forKey: "first_time")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
                .environmentObject(commitViewModel)
        }
        .commands {
            SidebarCommands()
        }
        
        WindowGroup {
            AddTag()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: Window.addTagView.rawValue))
    }
}

enum Window: String {
    case mainView = "MainView"
    case addTagView = "AddTagView"
    
    func open() {
        if let url = URL(string: "MacCommitGenerator://\(self.rawValue)") {
            NSWorkspace.shared.open(url)
        }
    }
}
