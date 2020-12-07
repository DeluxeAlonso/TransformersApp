//
//  Transformer.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

struct Transformer: Codable {

    let id: String
    let name: String
    let strength: Int
    let intelligence: Int
    let speed: Int
    let endurance: Int
    let rank: Int
    let courage: Int
    let firepower: Int
    let skill: Int
    let type: TransformerType

    var rating: Int {
        strength + intelligence + speed + endurance + firepower
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case strength
        case intelligence
        case speed
        case endurance
        case rank
        case courage
        case firepower
        case skill
        case type = "team"
    }

}

// MARK: - Equatable

extension Transformer: Equatable {

    static func == (lhs: Transformer, rhs: Transformer) -> Bool {
        return lhs.strength == rhs.strength
            && lhs.intelligence == rhs.intelligence
            && lhs.speed == rhs.speed
            && lhs.endurance == rhs.endurance
            && lhs.courage == rhs.courage
            && lhs.firepower == rhs.firepower
            && lhs.skill == rhs.skill
    }

}

// MARK: - Comparable

extension Transformer: Comparable {

    static func < (lhs: Transformer, rhs: Transformer) -> Bool {

        if rhs.courage - lhs.courage >= 4 {
            return true
        }

        if rhs.strength - lhs.strength >= 3 {
            return true
        }

        if rhs.skill - lhs.skill >= 3 {
            return true
        }

        return lhs.rating < rhs.rating
    }

}
