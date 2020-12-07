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
    private var removedAutobots: [Transformer] = []

    private var decepticons: [Transformer] = []
    private var removedDecepticons: [Transformer] = []

    private var survivors: [Transformer] = []

    init(transformers: [Transformer]) {
        self.transformers = transformers
    }

    func startTransformerWar() -> TransformerWarScore {
        let dividedTransformers = divideTransformersByTeam()
        autobots = dividedTransformers.autobots
        decepticons = dividedTransformers.decepticons

        let numberOfBattles = min(autobots.count, decepticons.count)

        for i in 1 ... min(autobots.count, decepticons.count) {
            let autobot = autobots.removeFirst()
            let decepticon = decepticons.removeFirst()

            guard let battle = startBattle(autobot: autobot, decepticon: decepticon) else {
                return TransformerWarScore(numberOfBattler: i, winner: .draw)
            }

            if battle.type == .autobot {
                removedAutobots.append(battle)
            } else {
                removedDecepticons.append(battle)
            }
        }

        let removedAutobotsNames = removedAutobots.map { $0.name }
        let skippedAutobotsNames = autobots.map { $0.name }
        let totalSurvivorAutobots = removedAutobotsNames + skippedAutobotsNames

        let removedDecepticonsNames = removedDecepticons.map { $0.name }
        let skippedDecepticonsNames = decepticons.map { $0.name }
        let totalSurvivorDecepticons = removedDecepticonsNames + skippedDecepticonsNames

        if removedAutobots.count > removedDecepticons.count {
            return TransformerWarScore(numberOfBattler: numberOfBattles, winner: .autobots(winnersNames: totalSurvivorAutobots, losersNames: totalSurvivorDecepticons))
        } else if removedAutobots.count > removedDecepticons.count {
           return TransformerWarScore(numberOfBattler: numberOfBattles, winner: .decepticons(winnersNames: totalSurvivorDecepticons, losersNames: totalSurvivorAutobots))
        } else {
            return TransformerWarScore(numberOfBattler: numberOfBattles, winner: .draw)
        }
    }

    func startBattle(autobot: Transformer, decepticon: Transformer) -> Transformer? {
        let autobotHasReservedName = Contants.ReservedNames.contains(autobot.name)
        let decepticonHasReservedName = Contants.ReservedNames.contains(decepticon.name)

        switch (autobotHasReservedName, decepticonHasReservedName) {
        case (true, true):
            return nil
        case (true, false):
            return autobot
        case (false, true):
            return decepticon
        default:
            break
        }

        switch autobot < decepticon {
        case true:
            return decepticon
        case false:
            return autobot
        }
    }

    func divideTransformersByTeam() -> (autobots: [Transformer], decepticons: [Transformer]) {
        let autobots = transformers.filter { $0.type == .autobot }.sorted { $0.rank > $1.rank }

        let decepticons = transformers.filter { $0.type == .decepticon }.sorted { $0.rank > $1.rank }

        return (autobots, decepticons)
    }

}

extension TransformerWarUtil {

    struct Contants {
        static let ReservedNames = ["Optimus Prime", "Predaking"]
    }

}
