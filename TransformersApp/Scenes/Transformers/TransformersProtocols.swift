//
//  TransformersProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

protocol TransformersViewModelProtocol {

    var viewState: Bindable<TransformersViewState> { get }
    var receivedWarResultMessage: Bindable<String?> { get }
    var receivedErrorMessage: Bindable<String?> { get }

    var transformerCells: [TransformerCellViewModelProtocol] { get }

    func updateTransformerList(with transformer: Transformer)

    /**
     Retrieves all the current transformers.
     */
    func getTransformers()

    /**
     Removes a specific transformer from the transformer list.

     - Parameter index: The index of the transformer to be removed.
     */
    func removeTransformer(at index: Int)

    /**
     Gets an specific transformer from the transformer list.

     - Parameter index: The index of the transformer to be retrieved..

     - Returns: A specific transformrer,
     */
    func transformer(at index: Int) -> Transformer

    /**
     Starts the battle between autobots and decepticons.
     */
    func startWar()
    
}

protocol TransformersInteractorProtocol {

    /**
     Fetches all the transformers from the server.

     - Parameter completion: Closure that returns a result with a transformers array or an error.
     */
    func getTransformers(completion: @escaping (Result<[Transformer], Error>) -> Void)

    /**
     Deletes and specific transformer on the server.

     - Parameter completion: Closure that returns an error is there if one or nil if not.
     */
    func deleteTransformer(with id: String, completion: @escaping (Error?) -> Void)
    
}

protocol TransformersCoordinatorProtocol: class {

    func setUpdateDelegate(_ delegate: TransformersUpdatable)

    /**
     Shows the form to create a brand new transformer.
     */
    func showTransformerAddForm()

    /**
     Shows the transformer edit screen.
     - Parameter transformer: Transformer to be shown on the edit screen.
     */
    func showTransformerEditForm(for transformer: Transformer)

}
