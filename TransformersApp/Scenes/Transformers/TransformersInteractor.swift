//
//  TransformersInteractor.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class TransformersInteractor: TransformersInteractorProtocol {

    private let secureStorage: SecureStorageProtocol
    private let transformerClient: TransformerClientProtocol

    // MARK: - Initializers

    init(secureStorage: SecureStorageProtocol,
         transformerClient: TransformerClientProtocol) {
        self.secureStorage = secureStorage
        self.transformerClient = transformerClient
    }

    // MARK: - TransformersInteractorProtocol

    func getTransformers(completion: @escaping (Result<[Transformer], Error>) -> Void) {
        guard let token = secureStorage.getAccessToken() else {
            completion(.failure(APIError.invalidData))
            return
        }
        transformerClient.getTransformers(accessToken: token) { result in
            switch result {
            case .success(let transformersResult):
                completion(.success(transformersResult.transformers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteTransformer(with id: String, completion: @escaping (Error?) -> Void) {
        guard let token = secureStorage.getAccessToken() else {
            completion(APIError.invalidData)
            return
        }
        transformerClient.deleteTransformer(with: id, accessToken: token) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

}
