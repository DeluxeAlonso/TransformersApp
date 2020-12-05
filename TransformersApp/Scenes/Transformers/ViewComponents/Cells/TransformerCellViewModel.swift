//
//  TransformerCellViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

protocol TransformerCellViewModelProtocol {

    var name: String { get }
    var rating: String { get }
    var iconName: String { get }

}

struct TransformerCellViewModel: TransformerCellViewModelProtocol {

    let name: String
    let rating: String
    let iconName: String

    init(_ transformer: Transformer) {
        name = transformer.name
        rating = "\(transformer.rating)"
        iconName = transformer.type.iconName
    }

}
