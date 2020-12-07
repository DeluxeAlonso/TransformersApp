//
//  TransformerDetailFactory.swift
//  TransformersApp
//
//  Created by Alonso on 12/7/20.
//

import Foundation

class TransformerDetailFactory: TransformerDetailFactoryProtocol {

    private let nameSectionInputs: [TransformerFormProtocol] = [NameTextInputForm()]

    private let valueSectionInputs: [TransformerFormProtocol] = [
        StrengthValueInputForm(),
        IntelligenceValueInputForm(),
        CourageValueInputForm(),
        SpeedValueInputForm(),
        EnduranceValueInputForm(),
        RankValueInputForm(),
        FirepowerValueInputForm(),
        SkillValueInputForm()
    ]

    private let typeSectionInputs: [TransformerFormProtocol] = [TeamTypeInputForm()]

    func getFormSections() -> [TransformerFormSection] {
        return [.name(forms: nameSectionInputs),
                .type(forms: typeSectionInputs),
                .value(forms: valueSectionInputs)]
    }

    func getAllInputs() -> [TransformerFormProtocol] {
        return nameSectionInputs + valueSectionInputs + typeSectionInputs
    }

}
