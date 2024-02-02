//
//  Home.swift
//  Synenergy
//
//  Created by Макс Лахман on 12.01.2024.
//
import SwiftUI

struct HomeView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(viewModel.data, id: \.league){ league in
                    VStack {
                        NavigationLink {
                            HomeDetailsView(main: league)
                        } label: {
                            Image(league.photoLeague).resizable().scaledToFit().padding()
                        }
                    }
                }
            }.background(Color("MainColorSecond"))
        }

         
     }
}





#Preview {
    HomeView()
        .environment(HomeMenuProductsViewModel())
}





