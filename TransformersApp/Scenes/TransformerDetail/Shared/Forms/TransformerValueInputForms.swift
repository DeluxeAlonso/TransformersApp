//
//  TransformerValueInputForms.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

struct StrengthValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .strength

    var type: TransformerFormType = .value(title: "Strength")

}

struct IntelligenceValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .intelligence

    var type: TransformerFormType = .value(title: "Intelligence")

}

struct SpeedValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .speed

    var type: TransformerFormType = .value(title: "Speed")

}

struct CourageValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .courage

    var type: TransformerFormType = .value(title: "Courage")

}

struct EnduranceValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .endurance

    var type: TransformerFormType = .value(title: "Endurance")

}

struct FirepowerValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .firepower

    var type: TransformerFormType = .value(title: "Firepower")

}

struct SkillValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .skill

    var type: TransformerFormType = .value(title: "Skill")

}

struct RankValueInputForm: TransformerFormProtocol {

    var identifier: TransformerInputIdentifier = .rank

    var type: TransformerFormType = .value(title: "Rank")

}
