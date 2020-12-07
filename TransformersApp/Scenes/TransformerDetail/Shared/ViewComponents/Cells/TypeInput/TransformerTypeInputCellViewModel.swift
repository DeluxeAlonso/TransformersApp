//
//  TransformerTypeInputCellViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

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
