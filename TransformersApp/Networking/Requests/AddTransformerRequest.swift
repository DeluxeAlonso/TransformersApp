//
//  AddTransformerRequest.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct AddTransformerRequest: Encodable {

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

    enum CodingKeys: String, CodingKey {
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
