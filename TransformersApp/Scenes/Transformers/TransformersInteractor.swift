//
//  TransformersInteractor.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class TransformersInteractor: TransformersInteractorProtocol {

    private let secureStorage: SecureStorageProtocol
    private let authClient: AuthClientProtocol
    private let transformerClient: TransformerClientProtocol

    // MARK: - Initializers

    init(secureStorage: SecureStorageProtocol,
         authClient: AuthClientProtocol,
         transformerClient: TransformerClientProtocol) {
        self.secureStorage = secureStorage
        self.authClient = authClient
        self.transformerClient = transformerClient
    }

    // MARK: - TransformersInteractorProtocol

    func getTransformers(completion: @escaping (Result<[Transformer], Error>) -> Void) {
        let getTokenOperation = BlockOperation {
            self.getToken { _ in return }
        }

        let getTransformersOperation = BlockOperation { [weak self] in
            guard let strongSelf = self,
                  let token = strongSelf.secureStorage.getAccessToken() else {
                completion(.failure(APIError.invalidData))
                return
            }
            strongSelf.transformerClient.getTransformers(accessToken: token) { result in
                switch result {
                case .success(let transformersResult):
                    completion(.success(transformersResult.transformers))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

        let operationQueue = OperationQueue()
        getTransformersOperation.addDependency(getTokenOperation)
        operationQueue.addOperations([getTransformersOperation, getTokenOperation], waitUntilFinished: true)
    }

    private func getToken(completion: @escaping (Result<String, Error>) -> Void) {
        if let existingToken = secureStorage.getAccessToken() {
            completion(.success(existingToken))
            return
        }

        authClient.getAccessToken { result in
            switch result {
            case .success(let tokenResult):
                self.secureStorage.setAccessToken(tokenResult.token)
                completion(.success(tokenResult.token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
