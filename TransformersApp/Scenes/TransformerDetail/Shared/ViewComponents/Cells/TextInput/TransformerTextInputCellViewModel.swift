//
//  TransformerTextInputCellViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

protocol TransformerTextInputCellViewModelProtocol: class {

    var identifier: TransformerInputIdentifier { get }
    var value: String { get set }
    var placeholderTitle: String { get }

}

final class TransformerTextInputCellViewModel: TransformerTextInputCellViewModelProtocol {

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
