//
//  MockTransformerDetailInteractor.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

import Foundation
@testable import TransformersApp

class MockTransformerDetailInteractor: TransformerDetailInteractorProtocol {

    var createTransformerResult: Result<Transformer, Error>?
    func createTransformer(with params: [String : Any], completion: @escaping (Result<Transformer, Error>) -> Void) {
        completion(createTransformerResult!)
    }

    var updateTransformerResult: Result<Transformer, Error>?
    func updateTransformer(with params: [String : Any], completion: @escaping (Result<Transformer, Error>) -> Void) {
        completion(updateTransformerResult!)
    }

}
