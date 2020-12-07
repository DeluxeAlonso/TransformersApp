//
//  TransformerWarUtil.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import Foundation

class TransformerWarUtil {

    private var transformers: [Transformer]

    private var autobots: [Transformer] = []
    private var survivedAutobots: [Transformer] = []

    private var decepticons: [Transformer] = []
    private var survivedDecepticons: [Transformer] = []

    init(transformers: [Transformer]) {
        self.transformers = transformers
    }

    func startTransformerWar() -> TransformerWarScore {
        let dividedTransformers = divideTransformersByTeam()
        autobots = dividedTransformers.autobots
        decepticons = dividedTransformers.decepticons

        if autobots.isEmpty {
            let decepticonsNames = decepticons.map { $0.name }
            return TransformerWarScore(numberOfBattles: 0, winner: .decepticons(winnersNames: decepticonsNames, losersNames: []))
        } else if decepticons.isEmpty {
            let autobotsNames = autobots.map { $0.name }
            return TransformerWarScore(numberOfBattles: 0, winner: .autobots(winnersNames: autobotsNames, losersNames: []))
        } else if autobots.isEmpty && decepticons.isEmpty {
            return  TransformerWarScore(numberOfBattles: 0, winner: .draw)
        }

        let numberOfBattles = min(autobots.count, decepticons.count)

        for i in 1 ... min(autobots.count, decepticons.count) {
            let autobot = autobots.removeFirst()
            let decepticon = decepticons.removeFirst()

            let battle = performSingleBattle(autobot: autobot, decepticon: decepticon)
            switch battle {
            case .autobot:
                survivedAutobots.append(autobot)
            case .decepticon:
                survivedDecepticons.append(decepticon)
            case .finishDraw:
                return TransformerWarScore(numberOfBattles: i, winner: .draw)
            case .draw:
                break
            }
        }

        let survivedAutobotsNames = survivedAutobots.map { $0.name }
        let skippedAutobotsNames = autobots.map { $0.name }
        let totalSurvivorAutobots = survivedAutobotsNames + skippedAutobotsNames

        let survivedDecepticonsNames = survivedDecepticons.map { $0.name }
        let skippedDecepticonsNames = decepticons.map { $0.name }
        let totalSurvivorDecepticons = survivedDecepticonsNames + skippedDecepticonsNames

        if survivedAutobots.count > survivedDecepticons.count {
            return TransformerWarScore(numberOfBattles: numberOfBattles, winner: .autobots(winnersNames: totalSurvivorAutobots, losersNames: totalSurvivorDecepticons))
        } else if survivedAutobots.count < survivedDecepticons.count {
           return TransformerWarScore(numberOfBattles: numberOfBattles, winner: .decepticons(winnersNames: totalSurvivorDecepticons, losersNames: totalSurvivorAutobots))
        } else {
            return TransformerWarScore(numberOfBattles: numberOfBattles, winner: .draw)
        }
    }

    /**
     Performs a battle between a single autobot and a single decepticon.

     - Parameter autobot: Battling autobot.
     - Parameter decepticon: Battling decepticon.


     - Returns: A battle result
     */
    func performSingleBattle(autobot: Transformer, decepticon: Transformer) -> SingleBattleResult {
        let autobotHasReservedName = Contants.ReservedNames.contains(autobot.name)
        let decepticonHasReservedName = Contants.ReservedNames.contains(decepticon.name)

        switch (autobotHasReservedName, decepticonHasReservedName) {
        case (true, true):
            return .finishDraw
        case (true, false):
            return .autobot
        case (false, true):
            return .decepticon
        default:
            break
        }

        if autobot == decepticon {
            return .draw
        }

        // Use Comparable protocol methods in Transformer type to apply comparison rules.
        switch autobot < decepticon {
        case true:
            return .decepticon
        case false:
            return .autobot
        }
    }

    func divideTransformersByTeam() -> (autobots: [Transformer], decepticons: [Transformer]) {
        let autobots = transformers.filter { $0.type == .autobot }.sorted { $0.rank > $1.rank }

        let decepticons = transformers.filter { $0.type == .decepticon }.sorted { $0.rank > $1.rank }

        return (autobots, decepticons)
    }

    func formatWarScore(_ score: TransformerWarScore) -> String {
        let winnersTeamText: String
        let losersTeamText: String
        switch score.winner {
        case .autobots(let winnersNames, let losersNames), .decepticons(let winnersNames, let losersNames):
            winnersTeamText = winnersNames.joined(separator: ", ")
            losersTeamText = losersNames.joined(separator: ", ")
            return "Number of battles: \(score.numberOfBattles) \n\n Winning Team (\(score.winner.winningTeamName)): \(winnersTeamText) \n\n Losing Team (\(score.winner.losingTeamName)): \(losersTeamText)"
        case .draw:
            return "It was a draw!"
        }
    }

}

extension TransformerWarUtil {

    struct Contants {
        static let ReservedNames = ["Optimus Prime", "Predaking"]
    }

}
