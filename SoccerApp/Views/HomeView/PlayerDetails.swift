//
//  PlayerDetails.swift
//  Synenergy
//
//  Created by Макс Лахман on 29.01.2024.
//

import SwiftUI

struct PlayerDetails: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    var player : Player
    var body: some View {
        VStack{
            HStack{
                Text("\(player.name)")
            }
            Text("\(player.x)")
            Text("\(player.number)")
        }
    }
}


