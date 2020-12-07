//
//  TransformerDetailInteractor.swift
//  TransformersApp
//
//  Created by Alonso on 12/6/20.
//

import Foundation

final class TransformerDetailInteractor: TransformerDetailInteractorProtocol {

    private let secureStorage: SecureStorageProtocol
    private let transformerClient: TransformerClientProtocol

    // MARK: - Initializers

    init(secureStorage: SecureStorageProtocol,
         transformerClient: TransformerClientProtocol) {
        self.secureStorage = secureStorage
        self.transformerClient = transformerClient
    }

    // MARK: - TransformerDetailInteractorProtocol

    func createTransformer(with params: [String: Any], completion: @escaping (Result<Transformer, Error>) -> Void) {
        guard let token = secureStorage.getAccessToken() else {
            completion(.failure(APIError.invalidData))
            return
        }
        transformerClient.createTransformer(with: params, accessToken: token) { result in
            switch result {
            case .success(let result):
                completion(.success(result.transformer))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateTransformer(with params: [String: Any], completion: @escaping (Result<Transformer, Error>) -> Void) {
        guard let token = secureStorage.getAccessToken() else {
            completion(.failure(APIError.invalidData))
            return
        }
        transformerClient.updateTransformer(with: params, accessToken: token) { result in
            switch result {
            case .success(let result):
                completion(.success(result.transformer))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
