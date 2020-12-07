//
//  EditTransformerViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation


class EditTransformerViewModel: TransformerDetailViewModelProtocol {

    private let transformer: Transformer
    private let interactor: TransformerDetailInteractorProtocol

    private var textInputFormCells: [TransformerTextCellViewModelProtocol] = []
    private var valueInputFormCells: [TransformerValueCellViewModelProtocol] = []
    private var typeInputFormCells: [TransformerTypeCellViewModelProtocol] = []

    let savedTransformer: Bindable<Transformer?> = Bindable(nil)
    let receivedErrorMessage: Bindable<String?> = Bindable(nil)

    var formSections: [TransformerFormSection]

    init(_ transformer: Transformer, interactor: TransformerDetailInteractorProtocol) {
        self.transformer = transformer
        self.interactor = interactor
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

    func shouldStartOnEditMode() -> Bool {
        return false
    }

    func saveTransformer() {
        // We update the transformer
        guard let name = textInputModel(for: .name)?.value, !name.isEmpty,
              let strength = valueInputModel(for: .strength)?.value,
              let intelligence = valueInputModel(for: .intelligence)?.value,
              let speed = valueInputModel(for: .speed)?.value,
              let endurance = valueInputModel(for: .endurance)?.value,
              let rank = valueInputModel(for: .rank)?.value,
              let courage = valueInputModel(for: .courage)?.value,
              let firepower = valueInputModel(for: .firepower)?.value,
              let skill = valueInputModel(for: .skill)?.value else {
            // TODO: - Error
            self.receivedErrorMessage.value = "There are some empty values."
            return
        }

        let type = typeInputModel(for: .team)?.value ?? .autobot

        let request: EditTransformerRequest = EditTransformerRequest(id: transformer.id, name: name, strength: strength, intelligence: intelligence, speed: speed, endurance: endurance, rank: rank, courage: courage, firepower: firepower, skill: skill, type: type)

        guard let params  = request.dictionary else { fatalError() }

        interactor.updateTransformer(with: params) { result in
            switch result {
            case .success(let transformer):
                self.savedTransformer.value = transformer
            case .failure(let error):
                self.receivedErrorMessage.value = error.localizedDescription
            }
        }
    }

}

extension Encodable {

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

}