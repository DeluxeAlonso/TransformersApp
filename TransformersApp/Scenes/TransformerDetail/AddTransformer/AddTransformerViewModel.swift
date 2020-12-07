//
//  AddTransformerViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

class AddTransformerViewModel: TransformerDetailViewModelProtocol {

    private let interactor: TransformerDetailInteractorProtocol

    private var textInputFormCells: [TransformerTextCellViewModelProtocol] = []
    private var valueInputFormCells: [TransformerValueCellViewModelProtocol] = []
    private var typeInputFormCells: [TransformerTypeCellViewModelProtocol] = []

    let savedTransformer: Bindable<Transformer?> = Bindable(nil)
    let startLoading: Bindable<Bool> = Bindable(false)
    let receivedErrorMessage: Bindable<String?> = Bindable(nil)

    var formSections: [TransformerFormSection]

    init(interactor: TransformerDetailInteractorProtocol) {
        self.interactor = interactor
        // Name Section
        let nameSectionForms: [TransformerFormProtocol] = [NameTextInputForm()]

        // Input
        let typeSectionForms: [TransformerFormProtocol] = [TeamTypeInputForm()]

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
                        .type(forms: typeSectionForms),
                        .value(forms: valueSectionForms)]

        let allForms = nameSectionForms + typeSectionForms + valueSectionForms

        createFormCellModels(for: allForms)
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
        return false
    }

    func shouldStartOnEditMode() -> Bool {
        return true
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

        let request = AddTransformerRequest(name: name, strength: strength, intelligence: intelligence, speed: speed, endurance: endurance, rank: rank, courage: courage, firepower: firepower, skill: skill, type: type)

        guard let params  = request.dictionary else { fatalError() }

        startLoading.value = true
        interactor.createTransformer(with: params) { result in
            self.startLoading.value = false
            switch result {
            case .success(let transformer):
                self.savedTransformer.value = transformer
            case .failure(let error):
                self.receivedErrorMessage.value = error.localizedDescription
            }
        }
    }

}
