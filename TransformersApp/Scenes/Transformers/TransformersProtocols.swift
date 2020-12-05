//
//  TransformersProtocols.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

protocol TransformersViewModelProtocol {

    var viewState: Bindable<TransformersViewState> { get }
    var transformerCells: [TransformerCellViewModelProtocol] { get }

    func getTransformers()
    
}

protocol TransformersInteractorProtocol {

    func getToken(completion: @escaping (Result<String, Error>) -> Void)

}