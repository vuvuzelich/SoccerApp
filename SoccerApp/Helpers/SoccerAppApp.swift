//
//  SoccerAppApp.swift
//  SoccerApp
//
//  Created by Макс Лахман on 02.02.2024.
//

import SwiftUI

@main
struct SoccerAppApp: App {
    @State private var viewModel = HomeMenuProductsViewModel()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(viewModel)
        }
    }
}
