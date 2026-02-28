//
//  HybridRNAppApp.swift
//  HybridRNApp
//
//  Created by hualai on 2026/1/23.
//

import SwiftUI

@main
struct HybridRNAppApp: App {
    // 注册 AppDelegate 以支持 React Native
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
