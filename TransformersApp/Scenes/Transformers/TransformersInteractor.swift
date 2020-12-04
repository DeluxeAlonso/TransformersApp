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

    init(secureStorage: SecureStorageProtocol, authClient: AuthClientProtocol) {
        self.secureStorage = secureStorage
        self.authClient = authClient
    }

    func getToken(completion: @escaping (Result<String, Error>) -> Void) {
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
                // If we receive an auth error we delete the access token.
                if error.isAuthError { self.secureStorage.deleteAccessToken() }
                completion(.failure(error))
            }
        }
    }

}
