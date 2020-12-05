//
//  TransformersViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

struct TransformersViewModel: TransformersViewModelProtocol {

    private let interactor: TransformersInteractorProtocol

    let viewState: Bindable<TransformersViewState> = Bindable(.initial)

    // MARK: - Computed Properties

    var transformerCells: [TransformerCellViewModelProtocol] {
        let transformers = viewState.value.currentTransformers
        return transformers.map { TransformerCellViewModel($0) }
    }

    // MARK: - Initializers

    init(interactor: TransformersInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - Public

    func getTransformers() {
        interactor.getTransformers { result in
            switch result {
            case .success(let transformers):
                self.viewState.value = transformers.isEmpty ? .empty : .populated(transformers)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
}
