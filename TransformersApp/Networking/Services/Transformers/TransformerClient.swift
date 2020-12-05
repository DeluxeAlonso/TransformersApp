//
//  TransformerClient.swift
//  TransformersApp
//
//  Created by Alonso on 12/4/20.
//

import Foundation

class TransformerClient: TransformerClientProtocol, APIClient {

    let session: URLSession

    // MARK: - Initializers

    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    // MARK: - TransformerClientProtocol

    func getTransformers(accessToken: String, completion: @escaping (Result<TransformersResult, APIError>) -> Void) {
        fetch(with: TransformerProvider.getTransformers(accessToken: accessToken).request, decode: { json -> TransformersResult? in
            guard let requestToken = json as? TransformersResult else { return nil }
            return requestToken
        }, completion: completion)
    }

}
