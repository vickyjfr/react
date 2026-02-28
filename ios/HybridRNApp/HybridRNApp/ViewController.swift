//
//  ViewController.swift
//  HybridRNApp
//
//  Created by hualai on 2026/1/23.
//


import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Native Home"
        view.backgroundColor = .systemBackground

        let btn = UIButton(type: .system)
        btn.setTitle("Open React Native Page", for: .normal)
        btn.addTarget(self, action: #selector(openRN), for: .touchUpInside)

        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func openRN() {
        let vc = RNViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
