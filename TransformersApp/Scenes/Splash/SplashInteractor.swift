//
//  SplashInteractor.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class SplashInteractor: SplashInteractorProtocol {

    private let secureStorage: SecureStorageProtocol
    private let authClient: AuthClientProtocol

    // MARK: - Initializers

    init(secureStorage: SecureStorageProtocol, authClient: AuthClientProtocol) {
        self.secureStorage = secureStorage
        self.authClient = authClient
    }

    // MARK: - plashInteractorProtocol

    func updateTokenIfNeeded(completion: @escaping (Error?) -> Void) {
        if secureStorage.getAccessToken() != nil {
            completion(nil)
            return
        }

        authClient.getAccessToken { result in
            switch result {
            case .success(let tokenResult):
                self.secureStorage.setAccessToken(tokenResult.token)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

}
