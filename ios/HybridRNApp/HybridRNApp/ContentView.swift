//
//  ContentView.swift
//  HybridRNApp
//
//  Created by hualai on 2026/1/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Native ContentView")

                NavigationLink("Open React Native Page") {
                    RNContainerView()
                        .ignoresSafeArea()
                        .navigationTitle("React Native")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
