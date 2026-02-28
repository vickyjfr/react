//
//  SceneDelegate.swift
//  HybridRNApp
//
//  Created by hualai on 2026/1/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        let root = ViewController()
        let nav = UINavigationController(rootViewController: root)

        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
