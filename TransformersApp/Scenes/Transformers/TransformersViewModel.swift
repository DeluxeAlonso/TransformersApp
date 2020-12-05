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
        interactor.getToken { result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
