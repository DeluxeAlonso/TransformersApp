//
//  TransformerValueInputCellViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

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
