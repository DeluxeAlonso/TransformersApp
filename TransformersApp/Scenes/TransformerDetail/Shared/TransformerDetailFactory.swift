//
//  TransformerDetailFactory.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import Foundation

class TransformerDetailFactory: TransformerDetailFactoryProtocol {

    private let nameSectionInputs: [TransformerInputProtocol] = [NameTextInput()]

    private let valueSectionInputs: [TransformerInputProtocol] = [
        StrengthValueInput(),
        IntelligenceValueInput(),
        CourageValueInput(),
        SpeedValueInput(),
        EnduranceValueInput(),
        RankValueInput(),
        FirepowerValueInput(),
        SkillValueInput()
    ]

    private let typeSectionInputs: [TransformerInputProtocol] = [TeamTypeInputForm()]

    func getFormSections() -> [TransformerFormSection] {
        return [.name(inputs: nameSectionInputs),
                .type(inputs: typeSectionInputs),
                .value(inputs: valueSectionInputs)]
    }

    func getAllInputs() -> [TransformerInputProtocol] {
        return nameSectionInputs + valueSectionInputs + typeSectionInputs
    }

}
