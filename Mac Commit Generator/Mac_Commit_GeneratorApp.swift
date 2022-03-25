//
//  MacCommitGeneratorApp.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/04.
//

import SwiftUI
import Foundation

@main
struct MacCommitGeneratorApp: App {
  @StateObject private var commitViewModel: CommitViewModel = CommitViewModel()
  @StateObject private var authenticaton: Authentication = Authentication()
  @StateObject private var tagViewModel: TagViewModel = TagViewModel()
  
  @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
  init() {
    if !UserDefaults.standard.bool(forKey: "first_time") {
      DefaultTagRepository.shared.reset()
      UserDefaults.standard.set(true, forKey: "first_time")
    }
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(commitViewModel)
        .environmentObject(authenticaton)
        .environmentObject(tagViewModel)
    }
    .commands {
      SidebarCommands()
    }
    .handlesExternalEvents(matching: Set(arrayLiteral: Window.mainView.rawValue))
    
    WindowGroup {
      AddTag()
        .environmentObject(tagViewModel)
      
    }
    .handlesExternalEvents(matching: Set(arrayLiteral: Window.addTagView.rawValue))
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  var statusItem: NSStatusItem?
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    if let menuButton = statusItem?.button {
      menuButton.image = #imageLiteral(resourceName: "StatusBarIcon")
      menuButton.action = #selector(menuButtonToggle)
    }
  }
  
  @objc func menuButtonToggle() {
    Window.mainView.openOrActivate()
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
  
  func openOrActivate() {
    guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "per.jongho.maccommitgenerator") else {
      return
    }
    NSWorkspace.shared.openApplication(at: url, configuration: NSWorkspace.OpenConfiguration())
  }
}
