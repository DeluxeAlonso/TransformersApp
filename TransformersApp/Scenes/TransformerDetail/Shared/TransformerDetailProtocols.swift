//
//  TransformerDetailProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

protocol TransformerDetailCoordinatorProtocol: class {

    func close()
    func close(with resultingTransformer: Transformer)

}

protocol TransformerDetailInteractorProtocol {

    func createTransformer(with params: [String: Any],
                           completion: @escaping (Result<Transformer, Error>) -> Void)
    func updateTransformer(with params: [String: Any],
                           completion: @escaping (Result<Transformer, Error>) -> Void)

}

protocol TransformerDetailFactoryProtocol {

    func getFormSections() -> [TransformerFormSection]
    func getAllInputs() -> [TransformerInputProtocol]

}

protocol TransformerDetailViewModelProtocol: class {

    var textInputCells: [TransformerTextInputCellViewModelProtocol] { get set }
    var valueInputCells: [TransformerValueInputCellViewModelProtocol] { get set }
    var typeInputCells: [TransformerTypeInputCellViewModelProtocol] { get set }

    var savedTransformer: Bindable<Transformer?> { get }
    var startLoading: Bindable<Bool> { get }
    var receivedErrorMessage: Bindable<String?> { get }

    var formSections: [TransformerFormSection] { get }

    func shouldAllowEditing() -> Bool
    func shouldStartOnEditMode() -> Bool

    func textInputModel(for identifier: TransformerInputIdentifier) -> TransformerTextInputCellViewModelProtocol?
    func valueInputModel(for identifier: TransformerInputIdentifier) -> TransformerValueInputCellViewModelProtocol?
    func typeInputModel(for identifier: TransformerInputIdentifier) -> TransformerTypeInputCellViewModelProtocol?

    func input(for section: Int, at index: Int) -> TransformerInputProtocol

    func saveTransformer()

}

extension TransformerDetailViewModelProtocol {

    func createInputCellModels(for inputs: [TransformerInputProtocol]) {
        for input in inputs {
            switch input.type {
            case .text(let placeholder):
                textInputCells.append(TransformerTextInputCellViewModel(identifier: input.identifier,
                                                                       placeholderTitle: placeholder))
            case .value(let title):
                valueInputCells.append(TransformerValueInputCellViewModel(identifier: input.identifier,
                                                                         inputTitle: title))
            case .type:
                typeInputCells.append(TransformerTypeInputCellViewModel(identifier: input.identifier))
            }
        }
    }

    func textInputModel(for identifier: TransformerInputIdentifier) -> TransformerTextInputCellViewModelProtocol? {
        return textInputCells.first { $0.identifier == identifier }
    }

    func valueInputModel(for identifier: TransformerInputIdentifier) -> TransformerValueInputCellViewModelProtocol? {
        return valueInputCells.first { $0.identifier == identifier }
    }

    func typeInputModel(for identifier: TransformerInputIdentifier) -> TransformerTypeInputCellViewModelProtocol? {
        return typeInputCells.first { $0.identifier == identifier }
    }

    func input(for section: Int, at index: Int) -> TransformerInputProtocol {
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

}
