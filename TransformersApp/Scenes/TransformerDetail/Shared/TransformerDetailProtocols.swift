//
//  TransformerDetailProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

protocol TransformerDetailViewModelProtocol {

    var savedTransformer: Bindable<Transformer?> { get }
    var receivedErrorMessage: Bindable<String?> { get }

    var formSections: [TransformerFormSection] { get }

    func shouldAllowEditing() -> Bool
    func shouldStartOnEditMode() -> Bool

    func textInputModel(for form: TransformerFormProtocol) -> TransformerTextCellViewModelProtocol
    func valueInputModel(for form: TransformerFormProtocol) -> TransformerValueCellViewModelProtocol
    func typeInputFormModel(for form: TransformerFormProtocol) -> TransformerTypeCellViewModelProtocol

    func form(for section: Int, at index: Int) -> TransformerFormProtocol

    func saveTransformer()

}

protocol TransformerDetailCoordinatorProtocol: class {

    func close()

}

protocol TransformerDetailInteractorProtocol {

    func createTransformer(with params: [String: Any],
                           completion: @escaping (Result<Transformer, Error>) -> Void)
    func updateTransformer(with params: [String: Any],
                           completion: @escaping (Result<Transformer, Error>) -> Void)

}
