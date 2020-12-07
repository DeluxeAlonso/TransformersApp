//
//  TransformerWarScore.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import Foundation

enum WarWinningTeam {
    case autobots(winnersNames: [String], losersNames: [String])
    case decepticons(winnersNames: [String], losersNames: [String])
    case draw

    var winningTeamName: String {
        switch self {
        case .autobots:
            return "Autobots"
        case .decepticons:
            return "Decepticons"
        case .draw:
            return "Draw"
        }
    }

    var losingTeamName: String {
        switch self {
        case .decepticons:
            return "Autobots"
        case .autobots:
            return "Decepticons"
        case .draw:
            return "Draw"
        }
    }
}

enum SingleBattleResult {
    case autobot
    case decepticon
    case draw
    case finishDraw
}

struct TransformerWarScore {

    let numberOfBattles: Int
    let winner: WarWinningTeam

}
