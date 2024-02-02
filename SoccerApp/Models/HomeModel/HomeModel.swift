import Foundation
import SwiftUI

struct Team: Codable {
    let team: String
    let played: Int
    let won: Int
    let drawn: Int
    let lost: Int
    let points: Int
    let photo: String
}

struct MatchResult: Codable {
    let homeTeamGoals: Int?
    let awayTeamGoals: Int?
    let homePlayerWhoScored : [PlayerWhoScored]?
    let awayPlayerWhoScored : [PlayerWhoScored]?
}


struct PlayerWhoScored : Codable {
    let name : String
    let lastName : String
    let minute : Int
}

struct Match: Codable, Identifiable {
    var id: Int
    let homeTeam: String
    let awayTeam: String
    let date: String
    let status: String
    let currentMinute: Int?
    let result: MatchResult
    let additionalFeatures: [AdditionalFeature]?
    let photoHomeTeam: String
    let photoAwayTeam: String
    let coefficientHomeTeam: Double
    let coefficientAwayTeam: Double
    let photo: String
    let stats : FootballMatchStats?
}

struct FootballMatchStats : Codable {
    var possessionHomeTeam: Double
    var possessionAwayTeam: Double
    var cornersHomeTeam: Int
    var cornersAwayTeam: Int
    var shotsHomeTeam: Int
    var shotsAwayTeam: Int
    var shotsOnTargetHomeTeam: Int
    var shotsOnTargetAwayTeam: Int
    var foulsHomeTeam: Int
    var foulsAwayTeam: Int
}



struct HomeModel: Codable {
    let league: String
    let photoLeague : String
    let table: [Team]
    let matches: [Match]
    let todayMatches: [Match]
}



struct AdditionalFeatureStats: Codable {
    let half: String
    let predictScoreHomeTeam: Int
    let predictScoreAwayTeam: Int
}

struct AdditionalFeatureStrategy: Codable {
    let wins: String
    let draws: String
    let losses: String
}

struct AdditionalFeature: Codable {
    let name: String
    let additionalInformationAboutMatch: AdditionalFeatureStats?
    let strategy: AdditionalFeatureStrategy?
    let lineups : Lineups?
}

struct Lineups: Codable {
    var homeTeam: TeamMatch
    var awayTeam: TeamMatch
}

struct Player: Identifiable, Codable {
    var id: Int
    var photo : String
    var number : Int
    var name: String
    var x: CGFloat
    var y: CGFloat
}

struct TeamMatch: Codable {
    var teamName: String
    var formation: String
    var players: [Player]
}







