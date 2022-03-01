//
//  CommitGeneratorApp.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

@main
struct CommitGeneratorApp: App {
    
    let persistenceController = PersistenceController.shared
    @StateObject var authentication : Authentication = Authentication()
    @StateObject var commitViewModel : CommitWriteHost.CommitViewModel = CommitWriteHost.CommitViewModel()
    @StateObject var bottomSheetManager : BottomSheetManager = BottomSheetManager()
    @Environment(\.scenePhase) var scenePhase
    
    init(){
        if !UserDefaults.standard.bool(forKey: "first_time") {
            persistenceController.reset()
            UserDefaults.standard.set(true, forKey: "first_time")
            
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
                .environmentObject(authentication)
                .environmentObject(commitViewModel)
                .environmentObject(bottomSheetManager)
                .fullScreenCover(isPresented: $bottomSheetManager.isPresent) {
                    BottomSheetContainer()
                        .environmentObject(authentication)
                        .environmentObject(commitViewModel)
                        .environmentObject(bottomSheetManager)
                }
                .onOpenURL { url in
                    DeepLinkHandler().openLink(with: url,authentication: authentication)
                }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
                case .background:
                    print("Scene is background")
                    persistenceController.save()
                case .inactive:
                    print("Scene is inactive")
                case .active:
                    print("Scene is active")
                @unknown default:
                    print("unknown App Status")
            }
        }
        
    }
}
