//
//  TransformersInteractor.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class TransformersInteractor: TransformersInteractorProtocol {

    private let keychainManager: KeychainManager
    private let authClient: AuthClient

    init(keychainManager: KeychainManager, authClient: AuthClient) {
        self.keychainManager = keychainManager
        self.authClient = authClient
    }

    func getToken(completion: @escaping (Result<String, Error>) -> Void) {
        authClient.getAccessToken { result in
            switch result {
            case .success(let tokenResult):
                self.keychainManager.token = tokenResult.token
                completion(.success(tokenResult.token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
