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
