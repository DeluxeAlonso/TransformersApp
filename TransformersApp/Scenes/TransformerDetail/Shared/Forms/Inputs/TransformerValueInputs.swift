//
//  TransformerValueInputs.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct StrengthValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .strength

    var type: TransformerInputType = .value(title: LocalizedStrings.strength.localized)

}

struct IntelligenceValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .intelligence

    var type: TransformerInputType = .value(title: LocalizedStrings.intelligence.localized)

}

struct SpeedValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .speed

    var type: TransformerInputType = .value(title: LocalizedStrings.speed.localized)

}

struct CourageValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .courage

    var type: TransformerInputType = .value(title: LocalizedStrings.courage.localized)

}

struct EnduranceValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .endurance

    var type: TransformerInputType = .value(title: LocalizedStrings.endurance.localized)

}

struct FirepowerValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .firepower

    var type: TransformerInputType = .value(title: LocalizedStrings.firepower.localized)

}

struct SkillValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .skill

    var type: TransformerInputType = .value(title: LocalizedStrings.skill.localized)

}

struct RankValueInput: TransformerInputProtocol {

    var identifier: TransformerInputIdentifier = .rank

    var type: TransformerInputType = .value(title: LocalizedStrings.rank.localized)

}
