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
            guard let result = json as? TransformersResult else { return nil }
            return result
        }, completion: completion)
    }

    func deleteTransformer(with id: String, accessToken: String, completion: @escaping (Result<EmptyResult, APIError>) -> Void) {
        fetch(with: TransformerProvider.deleteTransformer(accessToken: accessToken, transformerId: id).request, as: .propertyList, decode: { json -> EmptyResult? in
            guard let result = json as? EmptyResult else { return nil }
            return result
        }, completion: completion)
    }

}
