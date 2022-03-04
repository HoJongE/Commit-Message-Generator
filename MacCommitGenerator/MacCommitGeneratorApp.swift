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
        }
        .commands {
            SidebarCommands()
        }
    }
}
