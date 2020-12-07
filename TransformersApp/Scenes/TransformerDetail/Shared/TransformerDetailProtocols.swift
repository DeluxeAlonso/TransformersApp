//
//  TransformerDetailProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

protocol TransformerDetailCoordinatorProtocol: class {

    func close()

}

protocol TransformerDetailInteractorProtocol {

    func createTransformer(with params: [String: Any],
                           completion: @escaping (Result<Transformer, Error>) -> Void)
    func updateTransformer(with params: [String: Any],
                           completion: @escaping (Result<Transformer, Error>) -> Void)

}

protocol TransformerDetailFactoryProtocol {

    func getFormSections() -> [TransformerFormSection]
    func getAllInputs() -> [TransformerFormProtocol]

}

protocol TransformerDetailViewModelProtocol: class {

    var textInputFormCells: [TransformerTextCellViewModelProtocol] { get set }
    var valueInputFormCells: [TransformerValueCellViewModelProtocol] { get set }
    var typeInputFormCells: [TransformerTypeCellViewModelProtocol] { get set }

    var savedTransformer: Bindable<Transformer?> { get }
    var startLoading: Bindable<Bool> { get }
    var receivedErrorMessage: Bindable<String?> { get }

    var formSections: [TransformerFormSection] { get }

    func shouldAllowEditing() -> Bool
    func shouldStartOnEditMode() -> Bool

    func textInputModel(for identifier: TransformerInputIdentifier) -> TransformerTextCellViewModelProtocol?
    func valueInputModel(for identifier: TransformerInputIdentifier) -> TransformerValueCellViewModelProtocol?
    func typeInputModel(for identifier: TransformerInputIdentifier) -> TransformerTypeCellViewModelProtocol?

    func form(for section: Int, at index: Int) -> TransformerFormProtocol

    func saveTransformer()

}

extension TransformerDetailViewModelProtocol {

    func createFormCellModels(for forms: [TransformerFormProtocol]) {
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

    func textInputModel(for identifier: TransformerInputIdentifier) -> TransformerTextCellViewModelProtocol? {
        return textInputFormCells.first { $0.identifier == identifier }
    }

    func valueInputModel(for identifier: TransformerInputIdentifier) -> TransformerValueCellViewModelProtocol? {
        return valueInputFormCells.first { $0.identifier == identifier }
    }

    func typeInputModel(for identifier: TransformerInputIdentifier) -> TransformerTypeCellViewModelProtocol? {
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

}
