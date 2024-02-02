//
//  ContentView.swift
//  SoccerApp
//
//  Created by Макс Лахман on 02.02.2024.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabBarView()
    }
}

#Preview {
    StartView()
        .environment(HomeMenuProductsViewModel())
}
