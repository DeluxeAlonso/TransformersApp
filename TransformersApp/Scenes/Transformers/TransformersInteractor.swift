//
//  TransformersInteractor.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class TransformersInteractor: TransformersInteractorProtocol {

    private let authClient: AuthClient

    init(authClient: AuthClient) {
        self.authClient = authClient
    }

    func getToken(completion: @escaping (Result<String, Error>) -> Void) {
        authClient.getAccessToken { result in
            switch result {
            case .success(let tokenResult):
                completion(.success(tokenResult.token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
