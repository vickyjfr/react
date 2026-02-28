//
//  RNContainerView.swift
//  HybridRNApp
//
//  Created by hualai on 2026/1/23.
//

import SwiftUI
import UIKit

struct RNContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        RNViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
