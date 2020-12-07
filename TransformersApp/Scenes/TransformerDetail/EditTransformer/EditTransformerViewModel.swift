//
//  EditTransformerViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

final class EditTransformerViewModel: TransformerDetailViewModelProtocol {

    private let transformer: Transformer
    private let interactor: TransformerDetailInteractorProtocol
    private let factory: TransformerDetailFactoryProtocol

    var textInputCells: [TransformerTextInputCellViewModelProtocol] = []
    var valueInputCells: [TransformerValueInputCellViewModelProtocol] = []
    var typeInputCells: [TransformerTypeInputCellViewModelProtocol] = []

    let savedTransformer: Bindable<Transformer?> = Bindable(nil)
    let startLoading: Bindable<Bool> = Bindable(false)
    let receivedErrorMessage: Bindable<String?> = Bindable(nil)

    var formSections: [TransformerFormSection]

    init(_ transformer: Transformer,
         interactor: TransformerDetailInteractorProtocol,
         factory: TransformerDetailFactoryProtocol) {
        self.transformer = transformer
        self.interactor = interactor
        self.factory = factory

        self.formSections = factory.getFormSections()

        createInputCellModels(for: factory.getAllInputs())
        updateFormValues(with: transformer)
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
        valueInputModel(for: .strength)?.value = transformer.strength

        typeInputModel(for: .team)?.value = transformer.type
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
              let skill = valueInputModel(for: .skill)?.value,
              let type = typeInputModel(for: .team)?.value else {
            self.receivedErrorMessage.value = LocalizedStrings.emptyInputsTitle.localized
            return
        }

        let request: EditTransformerRequest = EditTransformerRequest(id: transformer.id, name: name, strength: strength, intelligence: intelligence, speed: speed, endurance: endurance, rank: rank, courage: courage, firepower: firepower, skill: skill, type: type)

        guard let params = request.dictionary else { fatalError() }

        startLoading.value = true
        interactor.updateTransformer(with: params) { result in
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
