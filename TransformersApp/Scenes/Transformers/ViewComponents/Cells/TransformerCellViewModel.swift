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

    var state: Bindable<TransformerCellState> { get }

    func startLoading()
    func stopLoading()

}

class TransformerCellViewModel: TransformerCellViewModelProtocol {

    let name: String
    let rating: String
    let iconName: String

    let state: Bindable<TransformerCellState> = Bindable(.regular)

    init(_ transformer: Transformer) {
        name = transformer.name
        rating = "\(transformer.rating)"
        iconName = transformer.type.iconName
    }

    func startLoading() {
        state.value = .loading
    }

    func stopLoading() {
        state.value = .regular
    }

}
