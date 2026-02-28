//
//  RNViewController.swift
//  HybridRNApp
//
//  Created by hualai on 2026/1/23.
//

import UIKit
import React

final class RNViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "React Native"

        let rootView = makeRootView()
        rootView.backgroundColor = UIColor.white   // 这里用 UIColor.white 最稳
        self.view = rootView
    }

    private func makeRootView() -> RCTRootView {
        #if DEBUG
        // 开发模式：从 Metro 加载（react/index.js）
        guard let jsURL = RCTBundleURLProvider.sharedSettings()
            .jsBundleURL(forBundleRoot: "index", fallbackExtension: nil) else {
            fatalError("Failed to get Metro bundle URL. Make sure Metro is running.")
        }

        return RCTRootView(
            bundleURL: jsURL,
            moduleName: "HybridRNApp",   // 必须与 AppRegistry.registerComponent 一致
            initialProperties: nil,
            launchOptions: nil
        )
        #else
        // Release：从 app 内置 bundle 加载（需要你打包 main.jsbundle）
        guard let jsURL = Bundle.main.url(forResource: "main", withExtension: "jsbundle") else {
            fatalError("main.jsbundle not found. Please bundle RN js for Release.")
        }

        return RCTRootView(
            bundleURL: jsURL,
            moduleName: "HybridRNApp",
            initialProperties: nil,
            launchOptions: nil
        )
        #endif
    }
}
