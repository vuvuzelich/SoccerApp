//
//  MatchDetailsSheetView.swift
//  Synenergy
//
//  Created by Макс Лахман on 24.01.2024.
//

import SwiftUI

struct MatchDetailsSheetView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    @State private var selectedFeature = "Line-Up"
    var currentMatch : Match
    
    var body: some View {
        NavigationStack{
            VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button(action: {
                                selectedFeature = "Live"
                            }) {
                                Text("Live")
                                    .padding()
                                    .background(selectedFeature == "Live" ? Color.black : Color.clear)
                                    .cornerRadius(8)
                                    .foregroundColor(selectedFeature == "Live" ? .white : .black)
                            }
                            
                            Button(action: {
                                selectedFeature = "Statistic"
                            }) {
                                Text("Statistic")
                                    .padding()
                                    .background(selectedFeature == "Statistic" ? Color.black : Color.clear)
                                    .cornerRadius(8)
                                    .foregroundColor(selectedFeature == "Statistic" ? .white : .black)
                            }
                            
                            Button(action: {
                                selectedFeature = "Line-Up"
                            }) {
                                Text("Line-Up")
                                    .padding()
                                    .background(selectedFeature == "Line-Up" ? Color.black : Color.clear)
                                    .cornerRadius(8)
                                    .foregroundColor(selectedFeature == "Line-Up" ? .white : .black)
                            }
                            
                            Button(action: {
                                selectedFeature = "H2h"
                            }) {
                                Text("H2h")
                                    .padding()
                                    .background(selectedFeature == "H2h" ? Color.black : Color.clear)
                                    .cornerRadius(8)
                                    .foregroundColor(selectedFeature == "H2h" ? .white : .black)
                            }
                        }.padding()
                    }.padding()

                VStack {
                    switch selectedFeature {
                    case "Live":
                        LiveView(currentMatch: currentMatch)
                    case "Statistic":
                        StatisticView(currentMatch: currentMatch)
                    case "Line-Up":
                        if let lineupsFeature = currentMatch.additionalFeatures?.first(where: { $0.name == "Line-Up" }) {
                            LineUpView(currentMatch: currentMatch, additionalFeatures: lineupsFeature)
                        } else {
                            EmptyView()
                        }
                    case "H2h":
                        H2hView(currentMatch: currentMatch)
                    default:
                        EmptyView()
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct LiveView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    var currentMatch: Match

    var body: some View {
        ScrollView {
            Image("video-player")
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .padding(10)

            HStack {
                Text("Рахунок на даний момент \(currentMatch.result.homeTeamGoals ?? 0) : \(currentMatch.result.awayTeamGoals ?? 0)")
            }


            if let additionalFeatures = currentMatch.additionalFeatures {
                ForEach(additionalFeatures, id: \.name) { feature in
                    if feature.name == "Live" {
                        if let stats = feature.additionalInformationAboutMatch {
                            // Unwrap and display information about the match in real-time
                            Text("Тайм: \(stats.half)")
                            Text("Прогноз на гру: \(stats.predictScoreHomeTeam) - \(stats.predictScoreAwayTeam)")
                        }
                    }
                }
            }
        }
    }
}


struct H2hView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    
    var currentMatch : Match
    var body: some View {
        // Ваш код для представления H2h
        HStack {
            Text("Рахунок на даний момент \(currentMatch.result.homeTeamGoals ?? 0) : \(currentMatch.result.awayTeamGoals ?? 0)")
        }

    }
}


struct StatisticView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    
    var currentMatch : Match
    var body: some View {
        ScrollView{
            HStack {
                Text("Рахунок на даний момент \(currentMatch.result.homeTeamGoals ?? 0) : \(currentMatch.result.awayTeamGoals ?? 0)")
            }

            VStack(spacing: 0) {
                if let additionalFeatures = currentMatch.additionalFeatures {
                    ForEach(additionalFeatures, id: \.name) { el in
                        VStack(spacing: 0) {
                            HStack(alignment: .top, spacing: 0) {
                                Text(el.lineups?.homeTeam.teamName ?? "")
                                Spacer()
                                Text(el.lineups?.awayTeam.teamName ?? "")
                            }
                            
                            HStack(alignment: .top, spacing: 0) {
                                Text(el.lineups?.homeTeam.formation ?? "")
                                Spacer()
                                Text(el.lineups?.awayTeam.formation ?? "")
                            }
                            
                            HStack(alignment: .top, spacing: 0) {
                                VStack(alignment: .leading) {
                                    ForEach(el.lineups?.homeTeam.players ?? [], id: \.name) { player in
                                        Text("\(player.name)")
                                    }
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    ForEach(el.lineups?.awayTeam.players ?? [], id: \.name) { player in
                                        Text("\(player.name)")
                                    }
                                }
                            }
                            Spacer()
                        }
                    }.padding(.horizontal, 20)
                } else {
                    EmptyView()
                }
            }
        }
    }
}





    
    
#Preview {
    HomeView().environment(HomeMenuProductsViewModel())
}

