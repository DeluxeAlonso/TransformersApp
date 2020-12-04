//
//  AuthClient.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

class AuthClient: AuthClientProtocol, APIClient {

    let session: URLSession

    // MARK: - Initializers

    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    // MARK: - AuthClientProtocol

    func getAccessToken(completion: @escaping (Result<AccessTokenResult, APIError>) -> Void) {
        fetch(with: AuthProvider.getToken.request, as: .propertyList, decode: { json -> AccessTokenResult? in
            guard let requestToken = json as? AccessTokenResult else { return nil }
            return requestToken
        }, completion: completion)
    }

}
