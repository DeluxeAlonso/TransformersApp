//
//  MockTransformersInteractor.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

import Foundation
@testable import TransformersApp

class MockTransformersInteractor: TransformersInteractorProtocol {

    var getTransformersResult: Result<[Transformer], Error>?
    func getTransformers(completion: @escaping (Result<[Transformer], Error>) -> Void) {
        completion(getTransformersResult!)
    }

    var deleteTransformerError: Error?
    func deleteTransformer(with id: String, completion: @escaping (Error?) -> Void) {
        completion(deleteTransformerError)
    }

}
