//
//  TransformersViewModel.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

class TransformersViewModel: TransformersViewModelProtocol {

    private let interactor: TransformersInteractorProtocol

    let viewState: Bindable<TransformersViewState> = Bindable(.initial)
    let receivedError: Bindable<Error?> = Bindable(nil)

    // MARK: - Computed Properties

    private var transformers: [Transformer] = [] {
        didSet {
            transformerCells = transformers.map { TransformerCellViewModel($0) }
            viewState.value = transformers.isEmpty ? .empty : .populated
        }
    }

    var transformerCells: [TransformerCellViewModelProtocol] = []

    // MARK: - Initializers

    init(interactor: TransformersInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - Public

    func getTransformers() {
        interactor.getTransformers { result in
            switch result {
            case .success(let transformers):
                self.transformers = transformers
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }

    func removeTransformer(at index: Int) {
        let transformerToDelete = transformers[index]

        startLoadingForCell(at: index)
        interactor.deleteTransformer(with: transformerToDelete.id) { error in
            self.stopLoadingForCell(at: index)
            guard error == nil else {
                self.receivedError.value = error
                return
            }
            self.transformers.remove(at: index)
        }
    }

    // MARK: - Private

    private func startLoadingForCell(at index: Int) {
        let cellModelToStart = transformerCells[index]
        cellModelToStart.startLoading()
    }

    private func stopLoadingForCell(at index: Int) {
        let cellModelToStart = transformerCells[index]
        cellModelToStart.stopLoading()
    }
    
}
