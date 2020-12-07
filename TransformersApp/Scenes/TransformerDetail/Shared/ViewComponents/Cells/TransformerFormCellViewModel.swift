//
//  TransformerFormCellViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

// MARK: - Value Forms

protocol TransformerTextCellViewModelProtocol: class {

    var identifier: TransformerInputIdentifier { get }
    var value: String { get set }
    var placeholderTitle: String { get }

}

final class TransformerTextCellViewModel: TransformerTextCellViewModelProtocol {

    let identifier: TransformerInputIdentifier
    let placeholderTitle: String

    var value: String

    init(identifier: TransformerInputIdentifier, placeholderTitle: String, value: String) {
        self.identifier = identifier
        self.placeholderTitle = placeholderTitle
        self.value = value
    }

    convenience init(identifier: TransformerInputIdentifier, placeholderTitle: String) {
        self.init(identifier: identifier, placeholderTitle: placeholderTitle, value: "")
    }

}

// MARK: - Value Forms

protocol TransformerValueCellViewModelProtocol: class {

    var identifier: TransformerInputIdentifier { get }
    var inputTitle: String { get }
    var value: Int { get set }

}

final class TransformerValueCellViewModel: TransformerValueCellViewModelProtocol {

    let identifier: TransformerInputIdentifier
    let inputTitle: String

    var value: Int

    init(identifier: TransformerInputIdentifier, inputTitle: String, value: Int) {
        self.identifier = identifier
        self.inputTitle = inputTitle
        self.value = value
    }

    convenience init(identifier: TransformerInputIdentifier, inputTitle: String) {
        self.init(identifier: identifier, inputTitle: inputTitle, value: 1)
    }

}

// MARK: - Type Forms

protocol TransformerTypeCellViewModelProtocol: class {

    var identifier: TransformerInputIdentifier { get }
    var value: TransformerType? { get set }

}

final class TransformerTypeCellViewModel: TransformerTypeCellViewModelProtocol {

    let identifier: TransformerInputIdentifier
    var value: TransformerType?

    init(identifier: TransformerInputIdentifier, value: TransformerType?) {
        self.identifier = identifier
        self.value = value
    }

    convenience init(identifier: TransformerInputIdentifier) {
        self.init(identifier: identifier, value: nil)
    }

}
