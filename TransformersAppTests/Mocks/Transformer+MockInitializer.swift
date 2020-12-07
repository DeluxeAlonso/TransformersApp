//
//  Transformer+MockInitializer.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

@testable import TransformersApp

extension Transformer {

    static func with(id: String = "1",
                     name: String = "Job 1",
                     strength: Int = 1,
                     intelligence: Int = 1,
                     speed: Int = 1,
                     endurance: Int = 1,
                     rank: Int = 1,
                     courage: Int = 1,
                     firepower: Int = 1,
                     skill: Int = 1,
                     type: TransformerType = .autobot) -> Transformer {
        return Transformer(id: id, name: name, strength: strength, intelligence: intelligence, speed: speed, endurance: endurance, rank: rank, courage: courage, firepower: firepower, skill: skill, type: type)
    }

}
