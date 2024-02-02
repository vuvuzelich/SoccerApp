//
//  DetailsView.swift
//  Synenergy
//
//  Created by Макс Лахман on 16.01.2024.
//

import SwiftUI

struct HomeDetailsView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    var main: HomeModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(main.todayMatches, id: \.id) {match in
                    NavigationLink {
                        MatchDetailsView(currentMatch : match)
                    } label: {
                        HStack{
                            // Перша команда(відображення команди господарів поля)
                            FirstTeamView(match : match)
                            Spacer()
                            // Поточна хвилина , рахунок та статус
                            ScoreAndStatusMatchView(match: match)
                            
                            Spacer()
                            // Друга команда(відображення команди гостей)
                            SecondTeamView(match: match)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(Color("MainColor"))
                        .cornerRadius(20)
                        .padding()
                    }
                }
            }

        }
        .padding(.top, 1)
        .background(Color("MainColorSecond"))
        
    }
}

#Preview {
    HomeView()
        .environment(HomeMenuProductsViewModel())
}





struct FirstTeamView: View {
    let match : Match
    private var formattedCoefficient: String {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter.string(from: NSNumber(value: match.coefficientHomeTeam)) ?? "\(match.coefficientHomeTeam)"
        }
    var body: some View {
        VStack{
            ZStack {
                Circle().fill(.gray).frame(width: 100, height: 100)
                Image(match.photoHomeTeam).resizable().scaledToFit().frame(width: 50, height: 50)
            }
            Text(match.homeTeam)
            ZStack {
                Capsule().fill(.gray).frame(width: 50, height: 25)
                Text("\(formattedCoefficient)").bold()
            }
        }
    }
}


struct SecondTeamView: View {
    let match : Match
    private var formattedCoefficient: String {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter.string(from: NSNumber(value: match.coefficientAwayTeam)) ?? "\(match.coefficientAwayTeam)"
        }
    var body: some View {
        VStack{
            ZStack {
                Circle().fill(.gray).frame(width: 100, height: 100)
                Image(match.photoAwayTeam).resizable().scaledToFit().frame(width: 50, height: 50)
            }
            Text(match.awayTeam)
            ZStack {
                Capsule().fill(.gray).frame(width: 50, height: 25)
                Text("\(formattedCoefficient)").bold()
            }
        }
    }
}

struct ScoreAndStatusMatchView: View {
    let match : Match
    var body: some View {
        if let curentMinute = match.currentMinute{
            if match.status == "pending" || match.status == "break" {
                VStack {
                    Spacer()
                    ZStack{
                        Capsule().stroke(Color.gray , lineWidth: 2).frame(width: 80, height: 40, alignment: .center)
                        Text("\(curentMinute)'")
                    }
                    Text("\(match.status)").foregroundColor(.blue)
                    HStack{
                        Text(String(match.result.homeTeamGoals ?? 0)).font(.system(size: 60))
                        Text(":").font(.system(size: 30)).foregroundColor(.gray)
                        Text(String(match.result.awayTeamGoals ?? 0)).font(.system(size: 60))
                    }

                    
                }
            } else {
                VStack{
                    Spacer()
                    ZStack{
                        Capsule().stroke(Color.gray , lineWidth: 2).frame(width: 80, height: 40, alignment: .center)
                        
                        Text("\(curentMinute)'")
                    }
                    Spacer()
                    if match.status == "ongoing"{
                        HStack(){
                            Text(String(match.result.homeTeamGoals ?? 0)).font(.system(size: 60))
                            Text(":").font(.system(size: 30)).foregroundColor(.gray)
                            Text(String(match.result.awayTeamGoals ?? 0)).font(.system(size: 60))
                        }
                    }
                    
                    
                }
            }
        }
        else {
            VStack {
                ZStack{
                    Capsule().stroke(Color.clear , lineWidth: 2).frame(width: 80, height: 40, alignment: .center)
                    
                }
                Text("\(match.status)").foregroundColor(.green)
                Spacer()
            }
        }
    }
}





