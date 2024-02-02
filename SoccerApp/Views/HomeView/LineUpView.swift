//
//  LineUpView.swift
//  Synenergy
//
//  Created by Макс Лахман on 30.01.2024.
//

import SwiftUI

struct LineUpView: View {
    @Environment(HomeMenuProductsViewModel.self) var viewModel
    var currentMatch : Match
    var additionalFeatures : AdditionalFeature
    @State var isShowTeam = "HomeTeam"
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                Button {
                    isShowTeam = "HomeTeam"
                } label: {
                    Text("HomeTeam")
                        .padding()
                        .background(isShowTeam == "HomeTeam" ? Color.black : Color.clear)
                        .cornerRadius(8)
                        .foregroundColor(isShowTeam == "HomeTeam" ? .white : .black)
                }
                Button {
                    isShowTeam = "AwayTeam"
                } label: {
                    Text("AwayTeam")
                        .padding()
                        .background(isShowTeam == "AwayTeam" ? Color.black : Color.clear)
                        .cornerRadius(8)
                        .foregroundColor(isShowTeam == "AwayTeam" ? .white : .black)
                }
            }
            VStack{
                switch isShowTeam {
                case "HomeTeam" :
                    ZStack {
                        SoccerFieldView()
                        if let lineups = additionalFeatures.lineups {
                            ForEach(lineups.homeTeam.players, id: \.id) { player in
                                PlayerView(player: player)
                            }
                        }
                    }
                case "AwayTeam" :
                    ZStack {
                        SoccerFieldView()
                        if let lineups = additionalFeatures.lineups {
                            ForEach(lineups.awayTeam.players, id: \.id) { player in
                                PlayerView(player: player)
                            }
                        }
                    }
                default:
                    EmptyView()
                }

            }
        }
    }
}




struct PlayerView: View {
    var player: Player

    var body: some View {
        VStack(spacing : 0) {
            Image(player.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .shadow(radius: 5)
            
            HStack {
                Text(player.name)
                    .font(.caption)
                    .foregroundColor(.black)
                ZStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 20, height: 20)
                    Text("\(player.number)")
                        .font(.caption)
                        .foregroundColor(.white)
                }

            }
            .padding(5)
            .background(.white)
            .cornerRadius(20)
            

        }
        .padding(10)
        .position(x: player.x * UIScreen.main.bounds.width, y: player.y * UIScreen.main.bounds.height)
    }
}



struct SoccerFieldView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        ZStack{
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 15)
                .fill(Color("MainGray"))
                .padding()
                .frame(width: screenWidth, height: screenHeight)
                .overlay{
                    ZStack {
                        VStack {
                            HStack(alignment: .top){
                                UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 10, topTrailingRadius: 0).stroke(.gray).frame(width: 20, height: 20)
                                Spacer()
                                ZStack {
                                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 0).stroke(.gray).frame(width: 220, height: 110)
                                        .overlay {
                                            VStack {
                                                UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 0).stroke(.gray).frame(width: 150, height: 40)
                                                Spacer()
                                            }
                                    }
                                }
                                .overlay {
                                    ZStack {
                                        Circle()
                                            .trim(from: 0.0, to : 0.50)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 90, height: 90)
                                            .position(x: 110, y : 110)

                                    }
                                }
                                Spacer()
                                UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 10, bottomTrailingRadius: 0, topTrailingRadius: 15).stroke(.gray).frame(width: 20, height: 20)
                                
                            }.padding()
                            Spacer()
                        }
                    }

                }
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 15)
                .stroke(Color.gray, lineWidth : 2)
                .padding()
                .frame(width: screenWidth, height: screenHeight)
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .trim(from: 0.0, to : 0.50)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 190, height: 190)
                        .rotationEffect(Angle(degrees: 180.0))
                    Divider().background(.gray).padding()
                        .overlay {
                            Circle().fill(.gray)
                                .frame(width: 15, height: 15)
                        }
                }
            }
        }
    }
}


#Preview {
    HomeView().environment(HomeMenuProductsViewModel())
}
