//
//  TransformerWarScore.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import Foundation

/**
 Represents the winning team and includes information of winners and losers in case the war does not end in a draw.
 */
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

/**
 A single battle result that can be a winning autobot, decepticons, a draw, o a finish draw (draw that end the war).
 */
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
