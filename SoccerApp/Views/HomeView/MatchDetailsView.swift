//
//  MatchDetailsView.swift
//  Synenergy
//
//  Created by Макс Лахман on 24.01.2024.
//

import SwiftUI

struct MatchDetailsView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    var currentMatch : Match
    @State private var isShowSheetView = true
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center){
                    ZStack {
                        Circle().fill(.gray).frame(width: 100, height: 100)
                        Image(currentMatch.photoHomeTeam).resizable().scaledToFit().frame(width: 50, height: 50)
                    }
                    Text(currentMatch.homeTeam).font(.system(size: 20)).bold().padding()
                    VStack(alignment: .trailing, spacing: 10)  {
                        if let homePlayerWhoScored = currentMatch.result.homePlayerWhoScored {
                            ForEach(homePlayerWhoScored.sorted(by: { $0.minute < $1.minute }), id: \.minute) { player in
                                HStack {
                                    Text("\(player.minute)'").foregroundColor(.gray)
                                    Text("\(player.lastName)").lineLimit(1)
                                    Spacer()
                                }
                            }
                        }
                    }.padding(.leading, 10)
                }.padding(.leading, 10)
                Spacer()
                if let curentMinute = currentMatch.currentMinute{
                    if currentMatch.status == "pending" || currentMatch.status == "break" {
                        VStack {
                            
                            ZStack{
                                Capsule().stroke(Color.gray , lineWidth: 2).frame(width: 80, height: 40, alignment: .center)
                                Text("\(curentMinute)'")
                            }
                            Text("\(currentMatch.status)").foregroundColor(.red)
                            HStack(){
                                Text(String(currentMatch.result.homeTeamGoals ?? 0)).font(.system(size: 60))
                                Text(":").font(.system(size: 30)).foregroundColor(.gray)
                                Text(String(currentMatch.result.awayTeamGoals ?? 0)).font(.system(size: 60))
                            }
                            
                        }
                    } else {
                        VStack{
                            
                            ZStack{
                                Capsule().stroke(Color.gray , lineWidth: 2).frame(width: 80, height: 40, alignment: .center)
                                
                                Text("\(curentMinute)'")
                            }

                            if currentMatch.status == "ongoing"{
                                HStack(){
                                    Text(String(currentMatch.result.homeTeamGoals ?? 0)).font(.system(size: 60))
                                    Text(":").font(.system(size: 30)).foregroundColor(.gray)
                                    Text(String(currentMatch.result.awayTeamGoals ?? 0)).font(.system(size: 60))
                                }
                            }
                            
                            
                        }
                    }
                } else {
                    VStack {
                        ZStack{
                            Capsule().stroke(Color.clear , lineWidth: 2).frame(width: 80, height: 40, alignment: .center)
                            
                        }
                        Text("\(currentMatch.status)").foregroundColor(.green)

                    }
                }
                Spacer()
                VStack(alignment: .center){
                    ZStack {
                        Circle().fill(.gray).frame(width: 100, height: 100)
                        Image(currentMatch.photoAwayTeam).resizable().scaledToFit().frame(width: 50, height: 50)
                    }
                    Text(currentMatch.awayTeam).font(.system(size: 20)).bold().padding()
                    VStack(alignment: .trailing, spacing: 10)  {
                        if let awayPlayerWhoScored = currentMatch.result.awayPlayerWhoScored {
                            ForEach(awayPlayerWhoScored.sorted(by: { $0.minute < $1.minute }), id: \.minute) { player in
                                HStack {
                                    Text("\(player.minute)'").foregroundColor(.gray)
                                    Text("\(player.lastName)").lineLimit(1)
                                    Spacer()
                                }
                            }
                        }
                    }.padding(.trailing, 10)
                }.padding(.trailing, 10)
            }
            Spacer()
            Button {
                isShowSheetView.toggle()
            } label: {
                VStack {
                    Text("______")
                    Text("Details")
                }
            }

        }
        .padding(.top, 1)
        .background(Color("MainColorSecond"))
        .sheet(isPresented: $isShowSheetView){
            MatchDetailsSheetView(currentMatch: currentMatch)
                .presentationDetents([.medium, .large, .fraction(0.3)])
        }
    }
}

#Preview {
    HomeView().environment(HomeMenuProductsViewModel())
}
