//
//  TransformerValueInputs.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct StrengthValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .strength

    var type: TransformerInputType = .value(title: "Strength")

}

struct IntelligenceValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .intelligence

    var type: TransformerInputType = .value(title: "Intelligence")

}

struct SpeedValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .speed

    var type: TransformerInputType = .value(title: "Speed")

}

struct CourageValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .courage

    var type: TransformerInputType = .value(title: "Courage")

}

struct EnduranceValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .endurance

    var type: TransformerInputType = .value(title: "Endurance")

}

struct FirepowerValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .firepower

    var type: TransformerInputType = .value(title: "Firepower")

}

struct SkillValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .skill

    var type: TransformerInputType = .value(title: "Skill")

}

struct RankValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .rank

    var type: TransformerInputType = .value(title: "Rank")

}
