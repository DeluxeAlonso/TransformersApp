//
//  EditTransformerViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

class EditTransformerViewModel: TransformerDetailViewModelProtocol {

    var formSections: [TransformerFormSection]

    private var textInputFormCells: [TransformerTextCellViewModelProtocol] = []
    private var valueInputFormCells: [TransformerValueCellViewModelProtocol] = []
    private var typeInputFormCells: [TransformerTypeCellViewModelProtocol] = []

    init(_ transformer: Transformer) {

        // Name Section
        let nameSectionForms: [TransformerFormProtocol] = [NameTextInputForm()]

        // Value Section
        let valueSectionForms: [TransformerFormProtocol] = [
            StrengthValueInputForm(),
            IntelligenceValueInputForm(),
            CourageValueInputForm(),
            SpeedValueInputForm(),
            EnduranceValueInputForm(),
            RankValueInputForm(),
            FirepowerValueInputForm(),
            SkillValueInputForm()
        ]

        formSections = [.name(forms: nameSectionForms),
                        .value(forms: valueSectionForms)]

        let allForms = nameSectionForms + valueSectionForms

        createFormCellModels(for: allForms)
        updateFormValues(with: transformer)
    }

    private func createFormCellModels(for forms: [TransformerFormProtocol]) {
        for form in forms {
            switch form.type {
            case .text(let placeholder):
                textInputFormCells.append(TransformerTextCellViewModel(identifier: form.identifier,
                                                                       placeholderTitle: placeholder))
            case .value(let title):
                valueInputFormCells.append(TransformerValueCellViewModel(identifier: form.identifier,
                                                                         inputTitle: title))
            case .type:
                typeInputFormCells.append(TransformerTypeCellViewModel(identifier: form.identifier))
            }
        }
    }

    private func updateFormValues(with transformer: Transformer) {
        textInputModel(for: .name)?.value = transformer.name

        valueInputModel(for: .courage)?.value = transformer.courage
        valueInputModel(for: .endurance)?.value = transformer.endurance
        valueInputModel(for: .firepower)?.value = transformer.firepower
        valueInputModel(for: .intelligence)?.value = transformer.intelligence
        valueInputModel(for: .rank)?.value = transformer.rank
        valueInputModel(for: .skill)?.value = transformer.skill
        valueInputModel(for: .speed)?.value = transformer.speed
        valueInputModel(for: .strength)?.value = transformer.courage

        typeInputModel(for: .team)?.value = transformer.type
    }

    private func textInputModel(for identifier: TransformerInputIdentifier) -> TransformerTextCellViewModelProtocol? {
        return textInputFormCells.first { $0.identifier == identifier }
    }

    private func valueInputModel(for identifier: TransformerInputIdentifier) -> TransformerValueCellViewModelProtocol? {
        return valueInputFormCells.first { $0.identifier == identifier }
    }

    private func typeInputModel(for identifier: TransformerInputIdentifier) -> TransformerTypeCellViewModelProtocol? {
        return typeInputFormCells.first { $0.identifier == identifier }
    }

    func form(for section: Int, at index: Int) -> TransformerFormProtocol {
        let section = formSections[section]
        switch section {
        case .name(let forms):
            return forms[index]
        case .value(let forms):
            return forms[index]
        case .type(let forms):
            return forms[index]
        }
    }

    func textInputModel(for form: TransformerFormProtocol) -> TransformerTextCellViewModelProtocol {
        let cellModel = textInputFormCells.first { $0.identifier == form.identifier }
        guard let unwrappedCellModel = cellModel else { fatalError() }

        return unwrappedCellModel
    }

    func valueInputModel(for form: TransformerFormProtocol) -> TransformerValueCellViewModelProtocol {
        let cellModel = valueInputFormCells.first { $0.identifier == form.identifier }
        guard let unwrappedCellModel = cellModel else { fatalError() }

        return unwrappedCellModel
    }

    func typeInputFormModel(for form: TransformerFormProtocol) -> TransformerTypeCellViewModelProtocol {
        let cellModel = typeInputFormCells.first { $0.identifier == form.identifier }
        guard let unwrappedCellModel = cellModel else { fatalError() }

        return unwrappedCellModel
    }

    func shouldAllowEditing() -> Bool {
        return true
    }

    func saveTransformer() {
        // We update the transformer
        
    }

}

struct EditTransformerRequest: Encodable {

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

}
